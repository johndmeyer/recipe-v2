import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { DropDownsModule } from '@progress/kendo-angular-dropdowns';
import { HttpClient } from '@angular/common/http';

@Component({
    selector: 'dropdowntree',
    standalone: true,
    imports: [DropDownsModule],
    template: `
        <div class="dropdowntree">
            <kendo-dropdowntree
                kendoDropDownTreeExpandable
                [placeholder]="placeholderField"
                [childrenField]="'items'"
                [kendoDropDownTreeHierarchyBinding]="treeData"
                [textField]="textField"
                [valueField]="valueField"
                (valueChange)="valueChange($event)"               
            />
        </div>
    `
})

export class DropDownTree implements OnInit {
    // Properties: private, public, input, output
    public treeData: Array<any> = [];
    
    @Input() public domain: string = '';
    @Input() public path: string = '';
    @Output() public dropDownSelect = new EventEmitter<any>();

    // Constructor
    constructor (private http: HttpClient) { }
    
    // Lifecycle hooks
    ngOnInit(): void {
        this.http.get<any>(`http://${this.domain}/${this.path}`).subscribe(data => {
            this.treeData = data.data[`${this.path}s`];
        })        
    }

    // Methods


    get placeholderField() {
        return `Select ${this.path}...`;
    }

    get textField() {
        return `${this.path}Name`;
    }

    get valueField() {
        return `${this.path}Id`;
    }

    public valueChange(value: any): void {
        this.dropDownSelect.emit(`Item Name: ${value[this.textField]}, Item Id: ${value[this.valueField]}`);
    }
}