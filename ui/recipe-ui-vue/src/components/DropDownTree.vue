<script>
    import { DropDownTree } from '@progress/kendo-vue-dropdowns';
    import { filterBy } from '@progress/kendo-vue-data-tools';
    import { mapTree, extendDataItem } from '@progress/kendo-vue-common';

    const dataItemKey = "id";
    const subItemsField = "items";
    const expandField = "expanded";
    const selectField = "selected";
    const textField = "text";

    const fields = {
        dataItemKey,
        expandField,
        selectField,
        subItemsField
    };

    const data = [{ text: "", id: 1 }, { text: "", id: 2 }];

    const processTreeData = (data, state, fields) => {
        const { selectField, expandField, dataItemKey, subItemsField } = fields;
        const { expanded, value, filter } = state;
        const filtering = Boolean(filter && filter.value);

        return mapTree(
            filtering ? filterBy(data, [filter], subItemsField) : data,
            subItemsField,
            (item) => {
                const props = {
                    [expandField]: expanded.includes(item[dataItemKey]),
                    [selectField]: value && item[dataItemKey] === value[dataItemKey],
                };
                return filtering
                    ? extendDataItem(item, subItemsField, props)
                    : { ...item, ...props };
            }
        );
    };

    const expandedState = (item, dataItemKey, expanded) => {
        const nextExpanded = expanded.slice();
        const itemKey = item[dataItemKey];
        const index = expanded.indexOf(itemKey);
        index === -1 ? nextExpanded.push(itemKey) : nextExpanded.splice(index, 1);

        return nextExpanded;
    };

    export default {
        props: [
            'domain', 
            'path'
        ],
        components: {
            DropDownTree
        },
        computed: {
            treeData () {
                return processTreeData(this.dataItems, { expanded: this.expanded, value: this.value }, fields);
            }
        },
        data: function () {
            return {
                fields,
                textField: `${this.path}Name`,
                dataItemKey: `${this.path}Id`,
                subItemsField,
                expandField,
                selectField,
                dataItems: data,
                value: null,
                expanded: [data[0][dataItemKey]]
            }
        },
        emits: [
            'itemSelected'
        ],
        methods: {
            // onChange (e) {
            //     alert(`value selected ${JSON.stringify(e.value)}`)
            //     alert(`value selected ${e.value[`${this.path}Id`]}`)
            //     this.value = e.value;
            // },
            onExpandChange (e) {
                this.expanded = (expandedState(e.item, dataItemKey, this.expanded))
            }
        },
        mounted: function() {
            fetch(`${this.domain}/${this.path}`)
                .then(response => response.json())
                .then(data => this.dataItems = data.data[`${this.path}`]);
        }
    }
</script>
<template>
    <DropDownTree
        v-model="value"
        :dataItems="treeData"        
        :placeholder="'Please select ...'"
        :textField="textField"
        :dataItemKey="dataItemKey"
        :subItemsField="subItemsField"
        :selectField="selectField"
        :expandField="expandField"        
        @expandchange="onExpandChange"
        @change="(e) => { this.value = e.value; $emit('itemSelected', { selectedItemId: e.value[`${this.path}Id`] }) }"
    />
</template>