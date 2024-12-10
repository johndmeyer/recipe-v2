import { useState, useEffect } from 'react';
import { Grid, GridColumn } from '@progress/kendo-react-grid';

export default function ResultsTable({domain, filters}) {
    const [recipes, setData] = useState(null);
    
    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await fetch(`${domain}/recipe`);
                const json = await response.json();
                setData(json.data.recipe);
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        };
    
        fetchData();
    }, []);

    return (
        <div>
            <Grid data={recipes}>
                <GridColumn field="recipeName" />
                <GridColumn field="recipeDescription" />
            </Grid>
        </div>
    )
}