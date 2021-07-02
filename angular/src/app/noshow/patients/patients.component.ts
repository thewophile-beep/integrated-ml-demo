import { Component, OnInit, ViewChild } from '@angular/core';
import { PatientService } from '../../services/patient.service';
import { Patient } from '../../definitions/patient';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { PatientDetailComponent } from '../patient-detail/patient-detail.component';

@Component({
    selector: 'app-patients',
    templateUrl: './patients.component.html',
    styleUrls: ['./patients.component.css']
})
export class PatientsComponent implements OnInit {    
    patients: Patient[] = [];
    pageSize: number = 100;
    currPage: number = 0;
    totalNum: number = 0;
    lastPage: number = 1;
    
    constructor(private patientService: PatientService, public dialog: MatDialog) {}
    
    ngOnInit() {
        this.getAll();
    }
    
    getAll(): void {
        this.patientService.getAllPatients(this.currPage, this.pageSize).subscribe(
            response => {
                this.totalNum = Number(response.total),
                this.lastPage = Math.floor(this.totalNum / this.pageSize)
                this.patients = response.patients
            }
        );
    }
        
    delete(patient: Patient): void {
        this.patients = this.patients.filter(h => h !== patient);
        this.patientService.deletePatient(patient.patientId).subscribe(
            _ => this.getAll()
        );
    }
        
    updateEvent(event: PageEvent): void {
        this.pageSize = event.pageSize;
        this.currPage = event.pageIndex;
        this.lastPage = this.totalNum % this.pageSize
        this.getAll();
    }
    
    openDialog(patient: Patient) {
        const patientDialog = this.dialog.open(PatientDetailComponent, {
            data: patient.patientId
        });
        patientDialog.afterClosed().subscribe(() => this.getAll());
    }
        
    goToLastPage() {
        this.currPage = this.lastPage;
        this.getAll();
    }
}