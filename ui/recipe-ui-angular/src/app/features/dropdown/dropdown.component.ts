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
                [textField]="textField"
                [valueField]="valueField"
                [data]="dropdownData"
                [defaultItem]="defaultItem"
                (selectionChange)="selectionChange($event)"
            />
        </div>
    `
})

export class DropDown implements OnInit {
    // Properties: private, public, input, output
    public dropdownData: Array<any> = [];
    
    @Input() public domain: string = '';
    @Input() public path: string = '';
    @Output() public dropDownSelect = new EventEmitter<any>();

    // Constructor
    constructor (private http: HttpClient) { }
    
    // Lifecycle hooks
    ngOnInit(): void {
        this.http.get<any>(`http://${this.domain}/${this.path}`).subscribe(data => {
            this.dropdownData = data.data[`${this.path}s`];
        })        
    }

    // Methods
    get defaultItem() {
        const defaultItem: any = {};

        defaultItem[`${this.path}Id`] = null;
        defaultItem[`${this.path}Name`] = `Select ${this.path}...`;

        return defaultItem;
    }

    get textField() {
        return `${this.path}Name`;
    }

    get valueField() {
        return `${this.path}Id`;
    }

    public selectionChange(value: any): void {
        this.dropDownSelect.emit(value);
    }
}