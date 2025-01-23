import { useState, useEffect } from 'react';
import { DropDownList } from '@progress/kendo-react-dropdowns';

export default function DropDown({ domain, path }) {
    const itemId = `${path}Id`;
    const itemName = `${path}Name`;    

    const defaultItem = {};
    defaultItem[itemId] = null;
    defaultItem[itemName] = `Select ${path}...`

    const [dataItems, setData] = useState([]);
    
    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await fetch(`${domain}/${path}`);
                const json = await response.json();
                setData(json.data[`${path}s`]);
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        };
    
        fetchData();
    }, []);

    const handleChange = (event) => {
        alert(`Selected item text: ${event.target.value[itemName]}, value: ${event.target.value[itemId]}`);
    }

    return (
        <div>
            <DropDownList 
                data={dataItems}
                dataItemKey={itemId}
                defaultItem={defaultItem}
                textField={itemName}                
                onChange={handleChange}
            />                
        </div>
    )
}