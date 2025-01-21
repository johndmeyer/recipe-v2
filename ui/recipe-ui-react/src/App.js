import './App.css';
import reactLogo from './react-logo.png';
import webpackLogo from './webpack-logo.png';
import bootstrapLogo from './bootstrap-logo.png';
import kendoUiLogo from './kendo-ui-logo.png';

import dockerLogo from './docker-logo.png';
import amazonEcsLogo from './amazon-ecs-logo.png';
import awsLogo from './aws-fargate-logo.png';

import DropDown from './components/DropDown.js';
import ResultsTable from './components/ResultsTable.js';

const domain = 'http://35.89.111.188:3000';
 const filters = null;

function App() {
	return (
		<div className='App container'>
			<div className='row'>
				<h1>..-recipe-..</h1>
			</div>
			<div className='row built-with'>
				<span>Built with: </span>
				<span><img className='react-logo' src={reactLogo} /></span>
				<span><img className='webpack-logo' src={webpackLogo} /></span>
				<span><img className='bootstrap-logo' src={bootstrapLogo} /></span>
				<span><img className='kendo-ui-logo' src={kendoUiLogo} /></span>
			</div>
			<br />
			<div className='row hosted-on'>
				<span>Hosted on/using: </span>
				<span><img className='docker-logo' src={dockerLogo} /></span>
				<span><img className='amazon-ecs-logo' src={amazonEcsLogo} /></span>
				<span><img className='aws-logo' src={awsLogo} /></span>
			</div>
			<br />
			<div className='row controls'>
				<div className='col-sm-4'>
					<DropDown />
				</div>
				<div className='col-sm-4'></div>
				<div className='col-sm-4'></div>
			</div>
			<br />
			<div className='row results'>
				<ResultsTable 
					domain={domain}
					filters={filters}
				/>
			</div>
			<br />
			<div className='row edit'>
				<div className='col-sm-3'></div>
				<div className='col-sm-3'></div>
				<div className='col-sm-3'></div>
				<div className='col-sm-3'></div>
			</div>
			<div className='row modals'>

			</div>			
		</div>
	);
}

export default App;
