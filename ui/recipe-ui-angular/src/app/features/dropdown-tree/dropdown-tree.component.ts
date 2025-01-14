import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { DropDownsModule } from '@progress/kendo-angular-dropdowns';
import { HttpClient } from '@angular/common/http';

@Component({
    selector: 'dropdown',
    standalone: true,
    imports: [DropDownsModule],
    template: `
        <div class="dropdown">
            <kendo-dropdownlist 
                defaultItem="Select {{dataType}}"
                [data]="dropdownData"
                (selectionChange)="selectionChange($event)"
            />
        </div>
    `
    //templateUrl: './app.component.html',
    //styleUrl: './app.component.scss'
})

export class DropDown implements OnInit {
    // Properties: private, public, input, output
    public dropdownData: Array<string> = [
        'stuff',
        'things',
        'items',
        'cosas',
        'chochkis'
    ];

    @Input() public dataType: string = '';
    // @Input() public domain: string;
    // @Input() public path: string;
    @Output() public dropDownSelect = new EventEmitter<any>();

    // Constructor
    constructor ( 
        private http: HttpClient,
        //private dataType: string,
        // private _domain: string,
        // private _path: string
    ) {
        //this.dataType = this.dataType;
        // this.domain = this._domain;
        // this.path = this._path;
    }
    
    // Lifecycle hooks
    ngOnInit(): void {
        // this.http.get<any>('http://localhost:5000/recipe/1').subscribe(data => {
        //     this.gridData[0] = data.data.recipe;
        // })        
    }

    // Methods
    public selectionChange(value: any): void {
        this.dropDownSelect.emit(value);
    }
}