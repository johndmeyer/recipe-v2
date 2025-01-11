import { Component, OnInit } from '@angular/core';
import { KENDO_GRID } from '@progress/kendo-angular-grid';
import { HttpClient } from '@angular/common/http';

@Component({
    selector: 'results',
    imports: [KENDO_GRID],
    template: `
        <div class="results">
            <kendo-grid [data]="gridData">
                <kendo-grid-column field="recipeName" title="Name"> </kendo-grid-column>
                <kendo-grid-column field="recipeDescription" title="Description"> </kendo-grid-column>
                <kendo-grid-column field="recipeCookTime" title="Cook Time"> </kendo-grid-column>
                <kendo-grid-column field="difficultyName" title="Difficulty"> </kendo-grid-column>
            </kendo-grid>
        </div>
    `
    //templateUrl: './app.component.html',
    //styleUrl: './app.component.scss'
})

export class Results implements OnInit {
    constructor(private http: HttpClient) { }

	public gridData: unknown[] = [];

    ngOnInit(): void {
        this.http.get<any>('http://localhost:5000/recipe/1').subscribe(data => {
            this.gridData[0] = data.data.recipe;
        })        
    }
}