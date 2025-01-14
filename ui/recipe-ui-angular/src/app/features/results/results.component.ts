import { Component, OnInit } from '@angular/core';
import { GridModule } from '@progress/kendo-angular-grid';
import { HttpClient } from '@angular/common/http';

@Component({
    selector: 'results',
    imports: [
        GridModule
    ],
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
        this.http.get<any>('http://localhost:5000/recipe').subscribe(data => {
            this.gridData = data.data.recipes;
        })        
    }
}