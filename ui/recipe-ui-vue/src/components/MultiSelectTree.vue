<template>
    <div>
        <MultiSelectTree
            v-model="value"
            :dataItems="treeData"            
            :placeholder="'Select Criteria'"
            :textField="textField"
            :dataItemKey="dataItemKey"
            :checkField="checkField"
            :checkIndeterminateField="checkIndeterminateField"
            :subItemsField="subItemsField"
            :expandField="expandField"
            @expandchange="onExpandChange"
        />
    </div>
</template>

<script>
    import { MultiSelectTree } from "@progress/kendo-vue-dropdowns";
    import {
        processMultiSelectTreeData,
        expandedState
    } from "./MultiSelectTree-DataOperations";
  
    const dataItemKey = "id";
    const checkField = "checkField";
    const checkIndeterminateField = "checkIndeterminateField";
    const subItemsField = "items";
    const expandField = "expanded";
    const textField = "text";
  
    const fields = {
        dataItemKey,
        checkField,
        checkIndeterminateField,
        expandField,
        subItemsField
    };

    const data = [
        {
            text: "Ingredients",
            id: 1,
            items: [
                { 
                    text: "Meats", 
                    id: 2,
                    items: [
                        {
                            text: "Chicken",
                            id: 3                            
                        },
                        {
                            text: "Beef",
                            id: 4
                        }
                    ]
                },
                { 
                    text: "Vegitables", 
                    id: 5,
                    items: [
                        {
                            text: "Tomatoes",
                            id: 6
                        },
                        {
                            text: "Squash",
                            id: 7
                        }
                    ] 
                }
            ],
        },
        {
            text: "Decor",
            id: 8,
            items: [
                { text: "Bed Linen", id: 9 },
                { text: "Curtains & Blinds", id: 10 },
                { text: "Carpets", id: 11 },
            ],
        },
    ];
  
    export default {
        props: [],
        components: {
            MultiSelectTree
        },
        data: function () {
            return {
                textField,
                dataItemKey,
                checkField,
                checkIndeterminateField,
                subItemsField,
                expandField,
                dataItems: data,
                value: [],
                expanded: [data[0][dataItemKey]]
            };
        },
        computed: {
            treeData () {
                return  processMultiSelectTreeData(this.dataItems, { expanded: this.expanded, value: this.value, ...fields })
            }
        },
        methods: {
            onExpandChange (event) {
                this.expanded = (expandedState(event.item, dataItemKey, this.expanded))
            }
        }
    };
</script>
  