import { useCallback, useEffect, useMemo, useState } from 'react';
import { mapTree, extendDataItem } from '@progress/kendo-react-common';
import { filterBy } from '@progress/kendo-react-data-tools';
import { DropDownTree as KDropDownTree } from '@progress/kendo-react-dropdowns';


//const domain = 'http://34.223.67.224:3000';
//const path = 'tag'
// const dataItemKey = `${path}Id`;
// const textField = `${path}Name`;
// const selectField = 'selected';
// const expandField = 'expanded';
// const subItemsField = 'items';
// const fields = { selectField, expandField, dataItemKey, subItemsField };

// const processTreeData = (data, state, fields) => {
//     const { selectField, expandField, dataItemKey, subItemsField } = fields;
//     const { expanded, value, filter } = state;
//     const filtering = Boolean(filter && filter.value);

//     return mapTree(filtering ? filterBy(data, [filter], subItemsField) : data, subItemsField, (item) => {
//         const props = {
//             [expandField]: expanded.includes(item[dataItemKey]),
//             [selectField]: value && item[dataItemKey] === value[dataItemKey]
//         };
//         return filtering ? extendDataItem(item, subItemsField, props) : { ...item, ...props };
//     });
// };

// const expandedState = (item, dataItemKey, expanded) => {
//     const nextExpanded = expanded.slice();
//     const itemKey = item[dataItemKey];
//     const index = expanded.indexOf(itemKey);
//     index === -1 ? nextExpanded.push(itemKey) : nextExpanded.splice(index, 1);

//     return nextExpanded;
// };

export default function DropDownTree({ domain, path }) {
    const dataItemKey = `${path}Id`;
    const textField = `${path}Name`;
    const selectField = 'selected';
    const expandField = 'expanded';
    const subItemsField = 'items';
    const fields = { selectField, expandField, dataItemKey, subItemsField };

    const processTreeData = (data, state, fields) => {
        const { selectField, expandField, dataItemKey, subItemsField } = fields;
        const { expanded, value, filter } = state;
        const filtering = Boolean(filter && filter.value);

        return mapTree(filtering ? filterBy(data, [filter], subItemsField) : data, subItemsField, (item) => {
            const props = {
                [expandField]: expanded.includes(item[dataItemKey]),
                [selectField]: value && item[dataItemKey] === value[dataItemKey]
            };
            return filtering ? extendDataItem(item, subItemsField, props) : { ...item, ...props };
        });
    };

    const expandedState = (item, dataItemKey, expanded) => {
        const nextExpanded = expanded.slice();
        const itemKey = item[dataItemKey];
        const index = expanded.indexOf(itemKey);
        index === -1 ? nextExpanded.push(itemKey) : nextExpanded.splice(index, 1);

        return nextExpanded;
    };
    
    const [data, setData] = useState([{},{}]);
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

    const [value, setValue] = useState({ tagName: 'Tables & Chairs', tagId: 2 });
    const [expanded, setExpanded] = useState([data[0][dataItemKey]]);

    const onChange = (event) => setValue(event.value);
    const onExpandChange = useCallback(
        (event) => setExpanded(expandedState(event.item, dataItemKey, expanded)),
        [expanded]
    );

    const treeData = useMemo(() => processTreeData(data, { expanded, value }, fields), [expanded, value]);
    
    return (
        <div>
            <KDropDownTree 
                data={treeData}
                dataItemKey={dataItemKey}
                textField={textField}                
                onChange={onChange}
                onExpandChange={onExpandChange}
                placeholder={`Select...`}
            />                
        </div>
    )
}