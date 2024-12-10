import logo from './logo.svg';
import './App.css';

import ResultsTable from './components/ResultsTable.js';

const domain = 'http://10.1.10.28:3000';
 const filters = null;//{
// 	cookTime: null, 
// 	difficulty: null,
// 	tags: {}
// };

function App() {
	return (
		<div className="App">
			<h1>_*Recipe*_<img src={logo} className="App-logo" alt="logo" /></h1>

			<ResultsTable 
				domain={domain}
				filters={filters}
			/>
		</div>
	);
}

export default App;
