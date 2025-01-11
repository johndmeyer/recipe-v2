import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { Results } from './features/results/results.component';

@Component({
	selector: 'app-root',
	imports: [Results, RouterOutlet],
	templateUrl: './app.component.html',
	styleUrl: './app.component.scss'
})

export class AppComponent {
	angularLogoSrc = '../assets/images/angular-logo.png';
	title = 'recipe-ui-angular';
}
