import { useEffect, useState } from 'react';
import { mapTree, extendDataItem } from '@progress/kendo-react-common';
import { filterBy } from '@progress/kendo-react-data-tools';
import { DropDownTree as KDropDownTree } from '@progress/kendo-react-dropdowns';

// Most of the code for DropDownTree taken from here:
// https://www.telerik.com/kendo-react-ui/components/dropdowns/dropdowntree
// ... it's a bit buggy when getting the data from an api. I searched github 
// for an example of how to this - no luck.

export default function DropDownTree({ domain, path }) {
    const dataItemKey = `${path}Id`;
    const expandField = 'expanded';
    const selectField = 'selected';
    const subItemsField = 'items';
    const textField = `${path}Name`;

    const fields = {
        expandField,
        dataItemKey,
        selectField,
        subItemsField
    };

    const [value, setValue] = useState({});
    const [treeData, setTreeData] = useState([{ tagId: 1, tagName: 'initial' }, { tagId: 2, tagname: 'data' }]);
    const [expanded, setExpanded] = useState([treeData[0][dataItemKey]]);
    
    const expandedState = (item, dataItemKey, expanded) => {
        const nextExpanded = expanded.slice();
        const itemKey = item[dataItemKey];
        const index = expanded.indexOf(itemKey);
        index === -1 ? nextExpanded.push(itemKey) : nextExpanded.splice(index, 1);
        return nextExpanded;
    };

    const processTreeData = (data, state, fields) => {
        const { selectField, expandField, dataItemKey, subItemsField } = fields;
        const { expanded, value, filter } = state;

        const filtering = Boolean(filter && filter.value);

        return mapTree(filtering ? filterBy(data, [filter], subItemsField) : data, subItemsField, item => {
            const props = {
                [expandField]: expanded.includes(item[dataItemKey]),
                [selectField]: value && item[dataItemKey] === value[dataItemKey]
            };

            return filtering ? extendDataItem(item, subItemsField, props) : {
                ...item,
                ...props
            };
        });
    };

    const onChange = (e) => {
        if (e.value) {
            alert(`Selected item text: ${e.value[textField]}, value: ${e.value[dataItemKey]}`);
        }
        
        setValue(e.value);
    }

    const onExpandChange = (e) => setExpanded(expandedState(e.item, dataItemKey, [expanded]));

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await fetch(`${domain}/${path}`);
                const json = await response.json();
                const pathData = json.data[`${path}s`];                
                const treeData = processTreeData(pathData, { expanded, value }, fields);

                setExpanded(treeData[0][dataItemKey])
                setTreeData(treeData);
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        };
    
        fetchData();
    }, []);
    
    return (
        <div>
            <KDropDownTree 
                data={treeData}
                dataItemKey={dataItemKey}
                textField={textField}                
                onChange={onChange}
                onExpandChange={onExpandChange}
                placeholder={`Select ${path}...`}
            />                
        </div>
    )
}