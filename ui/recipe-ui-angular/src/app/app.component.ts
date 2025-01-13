import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { DropDown } from './features/dropdown/dropdown.component';
import { Results } from './features/results/results.component';

@Component({
	selector: 'app-root',
	imports: [
		DropDown,
		Results, 
		RouterOutlet
	],
	templateUrl: './app.component.html',
	styleUrl: './app.component.scss'
})

export class AppComponent {
	angularLogoSrc = '../assets/images/angular-logo.png';
	title = 'recipe-ui-angular';

	public handleDropDownSelect(value: any) {
		alert(`drop down value selected ${value}`)
	}
}
