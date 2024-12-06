<script>
	import { Grid } from '@progress/kendo-vue-grid';

	export default {
        props: [
            'domain'
        ],
        components: {
            Grid
        },
        data: function () {
            return {
                columns: [
					{
						title: 'Recipe Name',
						field: 'recipeName'
					},
					{
						title: 'Recipe Description',
						field: 'recipeDescription'
					},
                    {
                        title: 'Yield',
                        field: 'recipeYield'
                    }
				],
                data: []
            }
        },
        emits: [
            'gridRowClick'        
        ],
        mounted() {
            fetch(`${this.domain}/recipe`)
                .then(response => response.json())
                .then(data => this.data = data.data.recipe);
        }
    }
</script>
<template>
    <grid
        :data-items="data"
        :columns="columns"
        @rowclick="(e) => $emit('gridRowClick', e.dataItem.recipeId)"
    ></grid>
</template>
<style>
</style>