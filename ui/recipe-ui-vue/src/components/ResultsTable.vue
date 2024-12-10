<script>
	import { Grid } from '@progress/kendo-vue-grid';



	export default {
        props: [
            'domain',
            'filterCriteria'
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
                data: [],
                pageable: {
                    buttonCount: 5,
                    info: true,
                    type: 'numeric',
                    pageSizes: true,
                    previousNext: true
                },
                skip: 0,
                take: 10,
                total: 0
            }
        },
        emits: [
            'gridRowClick'        
        ],
        methods: {
            getRecipes() {
                let url = `${this.domain}/recipe`;

                if(this.filterCriteria) {
                    let queryCounter = 0;

                    for (const [key, value] of Object.entries(this.filterCriteria)) {
                        if (value != null) {
                            url = `${url}${queryCounter === 0 ? '?' : '&'}${key}=${value}`
                        }
                    }
                }

                fetch(url)
                    .then(response => response.json())
                    .then(data => {
                        this.data = data.data.recipe;
                        this.total = data.data.recipe.length;
                    });
            }
        },
        mounted() {
            this.getRecipes();
        },
        watch: {
            'filterCriteria.tagId': function() {
                this.getRecipes();
            },
            'filterCriteria.difficultyId': function() {
                alert('foo!')
                this.getRecipes();
            },
            'filterCriteria.recipeCookTime': function() {
                this.getRecipes();
            }
        }
    }


</script>
<template>
    <grid
        :data-items="data"
        :columns="columns"
        :pageable="pageable"
        :total="total"
        @rowclick="(e) => $emit('gridRowClick', e.dataItem.recipeId)"
    ></grid>
</template>
<style>
</style>