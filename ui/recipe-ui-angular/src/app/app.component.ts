import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { NgbModule } from '@ng-bootstrap/ng-bootstrap';

import { DropDown } from './features/dropdown/dropdown.component';
import { DropDownTree } from './features/dropdown-tree/dropdown-tree.component';
import { Results } from './features/results/results.component';

@Component({
	selector: 'app-root',
	imports: [
		DropDown,
		DropDownTree,
		NgbModule,
		Results, 
		RouterOutlet
	],
	templateUrl: './app.component.html',
	styleUrl: './app.component.scss'
})

export class AppComponent {
	public domain: string = 'https://web-app-recipe-api-hycxgpf9hmghade3.eastus2-01.azurewebsites.net'
	angularLogoSrc = 'angular-logo.png';
	title = 'recipe-ui-angular';

	public handleDropDownSelect(value: any) {
		alert(`drop down value selected ${value}`)
	}
}
