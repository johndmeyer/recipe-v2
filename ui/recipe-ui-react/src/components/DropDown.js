//import { useState, useEffect } from 'react';
import { DropDownList } from '@progress/kendo-react-dropdowns';

export default function DropDown() {

    const path = 'difficulty';
    const itemId = `${path}Id`;
    const itemName = `${path}Name`;
    

    const defaultItem = {};
    defaultItem[itemId] = null;
    defaultItem[itemName] = `Select ${path}...`

    const dataItems = [
        {
            "difficultyId": 1,
            "difficultyName": "Easy"
          },
          {
            "difficultyId": 2,
            "difficultyName": "Medium"
          },
          {
            "difficultyId": 3,
            "difficultyName": "Difficult"
          }
    ];
    // const [recipes, setData] = useState(null);
    
    // useEffect(() => {
    //     const fetchData = async () => {
    //         try {
    //             const response = await fetch(`${domain}/recipe`);
    //             const json = await response.json();
    //             setData(json.data.recipe);
    //         } catch (error) {
    //             console.error('Error fetching data:', error);
    //         }
    //     };
    
    //     fetchData();
    // }, []);

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