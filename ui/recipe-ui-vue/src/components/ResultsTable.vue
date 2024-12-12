<script>
    import { trashIcon } from "@progress/kendo-svg-icons";
	import { Grid as KGrid } from '@progress/kendo-vue-grid';
    import { Button as KButton } from '@progress/kendo-vue-buttons';

	export default {
        props: [
            'domain',
            'filterCriteria'
        ],
        components: {
            KButton,
            KChipList,
            KGrid,
            trashIcon
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
                    },
                    {
                        cell: 'deleteTemplate',
                        className: 'text-center',
                        width: '60px'
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
                trashIcon,
                total: 0
            }
        },
        emits: [
            'gridRowClick'        
        ],
        methods: {
            deleteRecipe(e) {
                fetch(`${this.domain}/recipe/${e.dataItem.recipeId}`, {
                    method: 'delete'
                });
            },
            getRecipes() {
                let url = `${this.domain}/recipe`;

                if(this.filterCriteria) {
                    let queryCounter = 0;

                    for (const [key, value] of Object.entries(this.filterCriteria)) {
                        if (value != null) {
                            url = `${url}${queryCounter === 0 ? '?' : '&'}${key}=${value}`
                            queryCounter ++;
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
                this.getRecipes();
            },
            'filterCriteria.recipeCookTime': function() {
                this.getRecipes();
            }
        }
    }


</script>
<template>
    <k-grid
        :data-items="data"
        :columns="columns"
        :pageable="pageable"
        :total="total"
        @rowclick="(e) => { if (e.event.target.nodeName != 'path' & e.event.target.nodeName != 'svg') { $emit('gridRowClick', e.dataItem.recipeId) } }"
    >
        <template v-slot:deleteTemplate="{ props }">
            <td>
                <k-button
                    :svg-icon="trashIcon"
                    @click="deleteRecipe(props)"
                />
            </td>
        </template>
    </k-grid>
</template>
<style>
    td.text-center {
        margin: 0px;
    }
</style>