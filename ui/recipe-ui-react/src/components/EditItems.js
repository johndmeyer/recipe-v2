import { TextBox, TextArea } from '@progress/kendo-react-inputs';
// import { useState, useEffect } from 'react';
// import { DropDownList } from '@progress/kendo-react-dropdowns';

export default function EditItems({ domain, path }) {
    // const itemId = `${path}Id`;
    // const itemName = `${path}Name`;    

    // const defaultItem = {};
    // defaultItem[itemId] = null;
    // defaultItem[itemName] = `Select ${path}...`

    // const [dataItems, setData] = useState([]);
    
    // useEffect(() => {
    //     const fetchData = async () => {
    //         try {
    //             const response = await fetch(`${domain}/${path}`);
    //             const json = await response.json();
    //             setData(json.data[`${path}s`]);
    //         } catch (error) {
    //             console.error('Error fetching data:', error);
    //         }
    //     };
    
    //     fetchData();
    // }, []);

    // const handleChange = (event) => {
    //     alert(`Selected item text: ${event.target.value[itemName]}, value: ${event.target.value[itemId]}`);
    // }

    return (
        <div className='container'>
            <div className='row'>
                <h3>Add / Edit {path}s</h3>            
            </div>
            <br />
            <form className="border" onSubmit={saveParent}>
                <div className='row'>
                    <div className='col-sm-5 text-start'>                    
                        New top level {path}
                    </div>
                    <div className='col-sm-5'>
                        <TextBox
                            value={newParent}
                        />
                    </div>
                    <div className='col-sm-2'>
                        <Button
                            type='submit'
                        >
                            Save
                        </Button>
                    </div>
                </div>
                <br />
                <div className='row'>
                    <div className='col-sm-5 text-start'>                    
                        New sub level {path}
                    </div>
                    <div className='col-sm-5'>
                        <TextBox
                            value={newChild}
                        />
                    </div>
                    <div className='col-sm-2'>
                        <Button
                            type='submit'
                        >
                            Save
                        </Button>
                    </div>
                </div>
            </form>
                        
        </div>
    )
}