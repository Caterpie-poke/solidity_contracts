pragma solidity ^0.4.23;
contract Patient {
    address own;
    string name;
    string symptom;
    address charge;
    constructor(address _own, string _name, string _symptom, address _charge) public {
        own = _own;
        name = _name;
        symptom = _symptom;
        charge = _charge;
    }
    function same(address _addr) public view returns (bool) {
        if(own == _addr)return true;
        else return false;
    }
    function getOwn() public view returns (address) {
        return own;
    }
    function getName() public view returns (string) {
        return name;
    }
    function getSymptom() public view returns (string) {
        return symptom;
    }
    function getCharge() public view returns (address) {
        return charge;
    }
}

contract Doctor {
    address own;
    string name;
    string specialty;
    constructor(address _own, string _name, string _specialty) public {
        own = _own;
        name = _name;
        specialty = _specialty;
    }
    function same(address _addr) public view returns (bool) {
        if(own == _addr)return true;
        else return false;
    }
    function getOwn() public view returns (address) {
        return own;
    }
    function getName() public view returns (string) {
        return name;
    }
    function getSpecialty() public view returns (string) {
        return specialty;
    }
}

contract Hospital {
    string name;
    address hs_master;
    uint pt_cnt;
    uint dc_cnt;
    constructor(string _name, address _hsmas) public {
        name = _name;
        hs_master = _hsmas;
        pt_cnt = 0;
        dc_cnt = 0;
    }

    mapping(uint => Patient) patients;
    mapping(uint => Doctor) doctors;

    function belongPatient(uint _pt, address _addr) public view returns (bool) {
        if(patients[_pt].same(_addr))return true;
        else return false;
    }
    function belongDoctor(uint _dc, address _addr) public view returns (bool) {
        if(doctors[_dc].same(_addr))return true;
        else return false;
    }
    function searchDocName(address _addr) public view returns (string) {
        for(uint i=0 ; i<dc_cnt ; i++){
            if(doctors[i].getOwn() == _addr){
                return doctors[i].getName();
            }
        }
        return "NotFound";
    }
    function setDoc(address _addr, string _name, string _specialty) public {
        Doctor d = new Doctor(_addr,_name,_specialty);
        doctors[dc_cnt] = d;
        dc_cnt++;
    }
    function setPat(address _own, string _name, string _symptom, address _charge) public {
        Patient p = new Patient(_own,_name,_symptom,_charge);
        patients[pt_cnt] = p;
        pt_cnt++;
    }
    function getHsMaster() public view returns (address) {
        return hs_master;
    }
    function getDoc(uint _dc) public view returns (string, string) {
        return (doctors[_dc].getName(), doctors[_dc].getSpecialty());
    }
    function getDocAddr(uint _dc) public view returns (address) {
        return doctors[_dc].getOwn();
    }
    function getPat(uint _pt) public view returns (string,string,string) {
        return (patients[_pt].getName(), patients[_pt].getSymptom(), searchDocName(patients[_pt].getCharge()));
    }
}

contract MedicalAssociation {
    address ma_master;
    uint hs_cnt;
    constructor(address _mmas) public {
        ma_master = _mmas;
        hs_cnt = 0;
    }

    mapping(uint => Hospital) hospitals;

    modifier onlyPatient(uint _hs, uint _pt){
        require(hospitals[_hs].belongPatient(_pt, msg.sender));
        _;
    }
    modifier onlyDoctor(uint _hs, uint _dc){
        require(hospitals[_hs].belongDoctor(_dc, msg.sender));
        _;
    }
    modifier onlyHsMaster(uint _hs){
        require(hospitals[_hs].getHsMaster() == msg.sender);
        _;
    }
    modifier onlyMaMaster(){
        require(getMaMaster() == msg.sender);
        _;
    }

    function getMaMaster() public view returns (address) {
        return ma_master;
    }
    function buildHospital(string _hsname, address _hsmas) public onlyMaMaster {
        Hospital h = new Hospital(_hsname, _hsmas);
        hospitals[hs_cnt] = h;
        hs_cnt++;
    }
    function setDoctor(uint _hs, address _addr, string _name, string _specialty) public onlyHsMaster(_hs) {
        hospitals[_hs].setDoc(_addr,_name,_specialty);
    }
    function setPatient(uint _hs, uint _dc, address _own, string _name, string _symptom) public onlyDoctor(_hs,_dc) {
        address chargeDoc = hospitals[_hs].getDocAddr(_dc);
        hospitals[_hs].setPat(_own, _name, _symptom, chargeDoc);
    }
    function getSelfDoctorInfo(uint _hs, uint _dc) public view onlyDoctor(_hs, _dc) returns (string, string) {
        return hospitals[_hs].getDoc(_dc);
    }
    function getSelfPatientInfo(uint _hs, uint _pt) public view onlyPatient(_hs, _pt) returns (string, string, string) {
        return hospitals[_hs].getPat(_pt);
    }
    function getAnyPatientInfo(uint _hs, uint _pt, uint _dc) public view onlyDoctor(_hs, _dc) returns (string,string,string) {
        return hospitals[_hs].getPat(_pt);
    }
    function getOtherHospitalPatientInfo(uint _hs, uint _pt, uint _selfhs, uint _selfdc) public view onlyDoctor(_selfhs, _selfdc) returns (string,string,string) {
        return hospitals[_hs].getPat(_pt);
    }
}

// EOL
