import mysql.connector
from fastapi import FastAPI, HTTPException
from mysql.connector import Error
from pydantic import BaseModel
from typing import Any, List, Dict

app = FastAPI(title="APC Phase 3 API", version="1.0.0")

DB_CONFIG = {
    "host": "127.0.0.1",
    "user": "root",
    "password": "",      
    "database": "apc_db" 
}

class PatientIn(BaseModel):
    pssn: str
    pname: str
    sex: str
    address: str
    date_of_birth: str
    pid: int | None = None
    poid: int | None = None


def get_db():
    try:
        return mysql.connector.connect(**DB_CONFIG)
    except Error as e:
        # This will show up as JSON in the response
        raise HTTPException(status_code=500, detail=f"DB connect error: {e}")


def run_query(q: str, p=None, fetch: bool = False):
    conn = get_db()
    cur = conn.cursor(dictionary=True)
    try:
        cur.execute(q, p or ())
        if fetch:
            rows = cur.fetchall()
            return rows
        conn.commit()
        return {"message": "Success"}
    except Error as e:
        conn.rollback()
        raise HTTPException(status_code=400, detail=f"SQL error: {e}")
    finally:
        cur.close()
        conn.close()


@app.get("/")
def root():
    return {
        "message": "APC Phase 3 API",
        "endpoints": ["/q1", "/q2", "/q3", "/q4", "/create_views", "/qv1", "/qv2", "/qv3", "/qv4", "/docs"]
    }


@app.post("/q1")
def expand_services():
    run_query("INSERT IGNORE INTO Speciality (SName) VALUES ('Pediatrics');")
    run_query(
        "INSERT IGNORE INTO Physician (PId, FName, LName, MInitial, HId) "
        "VALUES (601,'Emily','White','C',1);"
    )
    run_query(
        "INSERT IGNORE INTO PHYSICIAN_SPECIALITY (PId, SName) VALUES (601,'Pediatrics');"
    )
    run_query(
        "INSERT IGNORE INTO patient (PSSN,PName,Gender,Address,DateOfBirth,PId,PoId) "
        "VALUES ('22233445566','Timmy Jones','M',NULL,'2020-01-15',601,NULL);"
    )
    return {"message": "Q1 completed"}


@app.get("/q2")
def billing_info():
    return run_query(
        """
        SELECT p.PName AS PatientFullName,
               cp.PoName AS CoveragePolicyName,
               cp.PoType AS CoveragePolicyType,
               p.DateOfBirth
        FROM patient p
        JOIN CoveragePolicy cp ON cp.PoId = p.PoId;
        """,
        fetch=True
    )


@app.post("/q3")
def update_followup():
    run_query(
        """
        UPDATE consultation
        SET FDate='2025-08-01', FTime='11:00:00'
        WHERE PSSN='111-22-3333'
          AND CDate='2025-08-01'
          AND CTime='06:00:00';
        """
    )
    return {"message": "Follow-up updated"}


@app.post("/q4")
def delete_location():
    run_query(
        "DELETE FROM Hospital_Location "
        "WHERE HId=301 AND Location='1000 Hospital Dr, Cityville';"
    )
    return {"message": "Location deleted"}


@app.post("/create_views")
def create_views():
    run_query("DROP VIEW IF EXISTS HospitalLocationSummary;")
    run_query(
        """
        CREATE VIEW HospitalLocationSummary AS
        SELECT h.HName AS HospitalName,
               GROUP_CONCAT(DISTINCT hl.Location ORDER BY hl.Location SEPARATOR ',') AS Locations
        FROM hospital h
        JOIN hospital_location hl ON hl.HId = h.HId
        GROUP BY h.HId,h.HName;
        """
    )
    run_query("DROP VIEW IF EXISTS PatientAgeDistribution;")
    run_query(
        """
        CREATE VIEW PatientAgeDistribution AS
        SELECT p.PName AS PatientName,
               TIMESTAMPDIFF(YEAR,p.DateOfBirth,CURDATE()) AS Age
        FROM patient p;
        """
    )
    run_query("DROP VIEW IF EXISTS PhysicianSpecialityCount;")
    run_query(
        """
        CREATE VIEW PhysicianSpecialityCount AS
        SELECT CONCAT(ph.FName,' ',IFNULL(ph.MInitial,''),' ',ph.LName) AS PhysicianFullName,
               COUNT(DISTINCT ps.SName) AS SpecialityCount
        FROM physician ph
        LEFT JOIN physician_speciality ps ON ps.PId = ph.PId
        GROUP BY ph.PId;
        """
    )
    return {"message": "Views created"}


@app.get("/qv1")
def hospitals_cityville():
    return run_query(
        """
        SELECT HospitalName, Locations
        FROM HospitalLocationSummary
        WHERE FIND_IN_SET('Cityville', Locations) > 0;
        """,
        fetch=True
    )


@app.get("/qv2")
def age_over_30():
    return run_query(
        "SELECT PatientName FROM PatientAgeDistribution WHERE Age > 30;",
        fetch=True
    )


@app.get("/qv3")
def highest_specialities():
    return run_query(
        """
        SELECT PhysicianFullName, SpecialityCount
        FROM PhysicianSpecialityCount
        ORDER BY SpecialityCount DESC
        LIMIT 1;
        """,
        fetch=True
    )


@app.get("/qv4")
def average_age():
    return run_query(
        "SELECT AVG(Age) AS AverageAge FROM PatientAgeDistribution;",
        fetch=True
    )
