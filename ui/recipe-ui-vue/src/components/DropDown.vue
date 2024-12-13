<script>
    import { DropDownList } from '@progress/kendo-vue-dropdowns';

    export default {
        props: [
            'dataType',
            'domain',
            'path'
        ],
        components: {
            DropDownList
        },
        data: function () {
			const dataObjectName = `${this.dataType}s`;

			const itemId = `${this.dataType}Id`;
			const itemName = `${this.dataType}Name`;

			const defaultItem = {};
			defaultItem[itemId] = null;
			defaultItem[itemName] = `Select ${this.dataType}`;

            return {
				dataObjectName,
				defaultItem,
				itemId,
                itemName,                
                dataItems: []
            }
        },
        emits: [
            'dropDownSelect'        
        ],
        mounted() {
            fetch(`${this.domain}/${this.path}`)
                .then(response => response.json())
                .then(data => this.dataItems = data.data[this.dataObjectName]);
        }
    }

</script>
<template>
    <drop-down-list
  		:data-items="dataItems"
		:data-item-key="itemId"
		:text-field="itemName"
		:default-item="this.defaultItem"
		@change="(e) => $emit('dropDownSelect', { dataType: this.dataType, id: e.target.value[itemId], name: e.target.value[itemName] })"
    />
</template>
