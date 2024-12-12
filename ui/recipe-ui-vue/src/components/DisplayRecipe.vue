<script>
    import { ChipList as KChipList } from '@progress/kendo-vue-buttons';

    export default {
        props: [
            'recipeId',
            'domain',
            'path'
        ],
        components: {
            KChipList
        },
        data: function () {
            return {
                recipe: {},
                recipeEquipments: [],
                recipeIngredients: [],
                recipeTags: []
            }
        },
        mounted() {
            fetch(`${this.domain}/${this.path}`)
                .then(response => response.json())
                .then(data => {
                    this.recipe = data.data.recipe;
                    this.recipeEquipments = data.data.recipeEquipments;
                    this.recipeIngredients = data.data.recipeIngredients;
                    this.recipeTags = data.data.recipeTags;
                });
        }
    }
</script>
<template>
<div
    class="container"
>
    <div
        class="row"
    >
        <h3>
            {{ recipe.recipeName }}
        </h3>
    </div>
    <br />
    <div
        class="row"
    >
        <img 
            :src="recipe.recipePhotoUrl"
            style="width: 100%"
        />
    </div>
    <br />
    <div
        class="row text-start"
    >
        <div
            class="col-sm-12"
        >
            {{ recipe.recipeDescription }}
        </div>    
    </div>
    <br />
    <div
        class="row text-start"
    >
        <div
            class="col-sm-4"
        >
            <b>Difficulty:</b>{{ ` ${recipe.difficultyName}` }}
        </div>
        <div
            class="col-sm-4"
        >
            <b>Cook Time:</b>{{ ` ${recipe.recipeCookTime}` }}
        </div>
        <div
            class="col-sm-4"
        >
            <b>Yield:</b>{{ ` ${recipe.recipeYield}` }}
        </div>
    </div>
    <br />
    <div
        class="row text-start"
    >
        <div
            class="col-sm-12"
        >
            <b>Tags:</b>
        </div>
        <div
            class="col-sm-12"
        >
            <k-chip-list
                :rounded="'full'"
                :key="recipeTags"
                :default-data-items="this.recipeTags"
                :text-field="'tagName'"
            />
        </div>
    </div>
    <br />
    <div
        class="row text-start"
    >
        <div
            class="col-sm-4"
        >
            <b>Equipment:</b>
            <ul>
                <li v-for="item in recipeEquipments">
                    {{ item.equipmentName }}
                </li>
            </ul>
            <b>Ingredients:</b>
            <ul>
                <li v-for="item in recipeIngredients">
                    {{ `${item.quantity} ${item.unitName ?? ''} - ${item.ingredientName}` }}
                </li>
            </ul>
        </div>
        <div
            class="col-sm-8"
        >
            <b>Directions:</b>
            {{ recipe.recipeDirections }}
        </div>
    </div>
</div>
</template>
<style></style>