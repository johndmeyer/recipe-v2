import './App.css';
import { useState } from 'react';
import { Button } from '@progress/kendo-react-buttons';
import { Window } from '@progress/kendo-react-dialogs';

import DropDown from './components/DropDown.js';
import DropDownTree from './components/DropDownTree.js';
import ResultsTable from './components/ResultsTable.js';

import reactLogo from './react-logo.png';
import webpackLogo from './webpack-logo.png';
import bootstrapLogo from './bootstrap-logo.png';
import kendoUiLogo from './kendo-ui-logo.png';

import dockerLogo from './docker-logo.png';
import amazonEcsLogo from './amazon-ecs-logo.png';
import awsLogo from './aws-fargate-logo.png';

const domain = 'http://34.223.67.224:3000';
const filters = null;

function App() {
	const [newEditModal, setNewEditModal] = useState(false);
	const [editEquipmentsModal, setEditEquipmentsModal] = useState(false);
	const [editIngredientsModal, setEditIngredientsModal] = useState(false);
	const [editTagsModal, setEditTagsModal] = useState(false);

	const toggleNewEditModal = () => {
		setNewEditModal(!newEditModal);
	}
	const toggleEditEquipmentsModal = () => {
		setEditEquipmentsModal(!editEquipmentsModal);
	}
	const toggleEditIngredientsModal = () => {
		setEditIngredientsModal(!editIngredientsModal);
	}
	const toggleEditTagsModal = () => {
		setEditTagsModal(!editTagsModal);
	}

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
					<DropDownTree
						domain={domain}
						path='tag'
					/>
				</div>
				<div className='col-sm-4'>
					<DropDown 
						domain={domain}
						path='difficulty'
					/>
				</div>
				<div className='col-sm-4'>
					<DropDown 
						domain={domain}
						path='duration'
					/>
				</div>
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
				<div className='col-sm-3'>
					<Button
						onClick={toggleNewEditModal}
					>
						New Recipe
					</Button>
				</div>
				<div className='col-sm-3'>
					<Button
						onClick={toggleEditEquipmentsModal}
					>
						Edit Equipment
					</Button>
				</div>
				<div className='col-sm-3'>
					<Button
						onClick={toggleEditIngredientsModal}
					>
						Edit Ingredients
					</Button>
				</div>
				<div className='col-sm-3'>
					<Button
						onClick={toggleEditTagsModal}
					>
						Edit Tags
					</Button>
				</div>
			</div>
			<div className='row modals'>
				{
					newEditModal 
					&& 
					<Window
						title='New/Edit Recipe'
						onClose={toggleNewEditModal}
						initialHeight={450}
						initialWidth={650}
					/>
				}
				{
					editEquipmentsModal
					&& 
					<Window
						title='Edit Equipment'
						onClose={toggleEditEquipmentsModal}
						initialHeight={450}
						initialWidth={650}
					/>
				}
				{
					editIngredientsModal 
					&& 
					<Window
						title='Edit Ingredients'
						onClose={toggleEditIngredientsModal}
						initialHeight={450}
						initialWidth={650}
					/>
				}
				{
					editTagsModal 
					&& 
					<Window
						title='Edit Tags'
						onClose={toggleEditTagsModal}
						initialHeight={450}
						initialWidth={650}
					/>
				}
			</div>			
		</div>
	);
}

export default App;
