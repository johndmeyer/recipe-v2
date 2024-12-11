<script>
	import { plusIcon, trashIcon } from "@progress/kendo-svg-icons";
	import { Button as KButton } from '@progress/kendo-vue-buttons';
	import { 
		TextBox as KTextBox,
		TextArea as KTextArea
		} from '@progress/kendo-vue-inputs';
	import DropDown from './DropDown.vue';
	import DropDownTree from './DropDownTree.vue';
    
	export default {
		props: [
			'domain'
		],
        components: {
			DropDown,
			DropDownTree,
			KButton,
			KTextArea,
			KTextBox
        },
		data: function () {
            return {
				domain: this.domain,
				currentEquipment: {},
				currentIngredient: {
					ingredient: null,					
					quantity: null,
					unit: null			
				},
				currentTag: {},
				equipments: [],
				ingredients: [],
				recipeCookTime: null,
				recipeDifficulty: null,
				tags: [],
				plusIcon,
				trashIcon
            };
        },
		methods: {
			addEquipment(e) {
				// Add equipment to equipments array
				this.equipments.push(this.currentEquipment);

				// Reset inputs
				this.currentEquipment = null; 
			},
			addIngredient() {
				// Add ingredient type, quantity, and units to ingredients array
				this.ingredients.push({
					ingredientId: this.currentIngredient.ingredient.ingredientId,
					ingredientName: this.currentIngredient.ingredient.ingredientName,
					quantity: this.currentIngredient.quantity,
					unitAbbreviation: this.currentIngredient.unit.unitAbbreviation,
					unitId: this.currentIngredient.unit.unitId,
					unitName: this.currentIngredient.unit.unitName
				});

				// Reset inputs
				this.currentIngredient.quantity = null;
				this.currentIngredient.unit = null;
				this.currentIngredient.ingredient = null;
			},
			addTag() {
				// Add tag to tags array
				this.tags.push(this.currentTag);

				// Reset inputs
				this.currentTag = null;
			},
			deleteEquipment(index) {
				this.equipments.splice(index, 1);
			},
			deleteIngredient(index) {
				this.ingredients.splice(index, 1);
			},
			deleteTag(index) {
				this.tags.splice(index, 1);
			},
            handleDropDownSelect(e) {
			    var foo = "bar";
			     switch(e.dataType) {
					 case 'difficulty':
					     this.recipeDifficulty = e.id;
					 case 'cookTime':
					     this.recipeCookTime = e.id;
					 default:
					     return;
				 }
			},
			saveRecipe() {
				const data = {
					recipe: {
						recipeCookTime: this.recipeCookTime,
						recipeDescription: this.recipeDescription,
						recipeDifficulty: this.recipeDifficulty,						
						recipeDirections: this.recipeDirections,
						recipeName: this.recipeName,						
						recipePhotoUrl: this.recipePhotoUrl,
						recipeYield: this.recipeYield
					},					
					ingredients: this.ingredients,
					equipments: this.equipments,
					tags: this.tags
				};

				// TODO: validate data for correctness, type, sql injection, xss, etc...
				fetch(`${this.domain}/recipe`, {
					method: 'put',
					headers: {
					  	'Content-Type': 'application/json'
					},
					body: JSON.stringify(data)
				});

				alert(`Form Submitted ${this.recipeName} ${this.recipeIngredients}`);
			}
		}
    }
</script>
<template>	
	<div 
		class="row"
	>
		<div
			class="col-sm-12"
		>
			<k-text-box
				v-model="recipeName"
				:placeholder="'Recipe Name'"
			/>
		</div>			
	</div>
	<br />
	<div
		class="row"
	>
		<div
			class="col-sm-12"
		>
			<k-text-area
				v-model="recipeDescription"
				:placeholder="'Recipe Description'"
			/>
		</div>			
	</div>
	<br />
	<div
		class="row"
	>
		<div
			class="col-sm-4"
		>
			<drop-down
				:data-type="'difficulty'"
				:domain="domain"
				:path="'difficulty'"
				@dropDownSelect="handleDropDownSelect"
			/>
		</div>
		<div
			class="col-sm-4"
		>
			<drop-down
				:data-type="'cookTime'"
				:domain="domain"
				:path="'cookTime'"
				@dropDownSelect="handleDropDownSelect"
			/>
		</div>
		<div
			class="col-sm-4"
		>
			<k-text-box
				v-model="recipeYield"
				:placeholder="'Yield (servings)'"
			></k-text-box>
		</div>
	</div>
	<br />
	<div
		class="border"
	>
		<div
			class="row"
		>
			<div
				class="col-sm-12"
			>
				Ingredients
			</div>
		</div>
		<br />	
		<div
			class="row"
		>		
			<div
				class="col-sm-2"
			>
				<k-text-box
					v-model="this.currentIngredient.quantity"
					:placeholder="'#'"
				/>
			</div>
			<div
				class="col-sm-3"
			>
				<drop-down
					v-model="this.currentIngredient.unit"
					:data-type="'unit'"
					:domain="domain"
					:path="'unit/metric'"
					@dropDownSelect="handleDropDownSelect"
				/>
			</div>
			<div
				class="col-sm-6"
			>
				<drop-down-tree
					v-model="this.currentIngredient.ingredient"
					:domain="domain"
					:path="'ingredient'"
					@itemSelected="handleItemSelected"
				/>
			</div>
			<div
				class="col-sm-1 text-end"
			>
				<k-button
					:svg-icon="plusIcon"
					@click="addIngredient"
				/>
			</div>			
		</div>
		<br />
		<div
			v-if="ingredients.length > 0"
		>
			<div
				class="row"
				v-for="(item, index) in ingredients"
			>
				<div
					class="col-sm-2 text-start"
				>
					{{ item.quantity }}
				</div>
				<div
					class="col-sm-3 text-start"
				>
					{{ item.unitAbbreviation === 'n/a' ? item.unitName : item.unitAbbreviation }}
				</div>
				<div
					class="col-sm-6 text-start"
				>
					{{ item.ingredientName }}
				</div>
				<div
					class="col-sm-1 text-end"
				>
					<k-button
						:svg-icon="trashIcon"
						@click="deleteIngredient(index)"							
					/>
				</div>
			</div>
		</div>
	</div>
	<br />
	<div
		class="border"
	>
		<div
			class="row"
		>
			<div
				class="col-sm-12"
			>
				Equipment
			</div>
		</div>
		<br />
		<div
			class="row"
		>
			<div
				class="col-sm-11"
			>
				<drop-down-tree
					v-model="this.currentEquipment"
					:domain="domain"
					:path="'equipment'"
					@itemSelected="handleItemSelected"
				/>
			</div>
			<div
				class="col-sm-1 text-end"
			>
				<k-button
					:svg-icon="plusIcon"
					@click="addEquipment"
				/>
			</div>
		</div>
		<br />
		<div
			v-if="equipments.length > 0"
		>
			<div
				class="row"
				v-for="(item, index) in equipments"
			>
				<div
					class="col-sm-11 text-start"
				>
					{{ item.equipmentName }}
				</div>
				<div
					class="col-sm-1 text-end"
				>
					<k-button
						:svg-icon="trashIcon"
						@click="deleteEquipment(index)"							
					/>
				</div>
			</div>
		</div>
	</div>
	<br />
	<div
		class="border"
	>
		<div
			class="row"
		>
			<div
				class="col-sm-12"
			>
				Tags
			</div>
		</div>
		<br />
		<div
			class="row"
		>
			<div
				class="col-sm-11"
			>
				<drop-down-tree
					v-model="currentTag"
					:domain="domain"
					:path="'tag'"
				/>
			</div>
			<div
				class="col-sm-1 text-end"
			>
				<k-button
					:svg-icon="plusIcon"
					@click="addTag"
				/>
			</div>
		</div>
		<br />
		<div
			v-if="tags.length > 0"
		>
			<div
				class="row"
				v-for="(item, index) in tags"
			>
				<div
					class="col-sm-11 text-start"
				>
					{{ item.tagName }}
				</div>
				<div
					class="col-sm-1 text-end"
				>
					<k-button
						:svg-icon="trashIcon"
						@click="deleteTag(index)"							
					/>
				</div>
			</div>
		</div>
	</div>
	<br />
	<div
		class="row"
	>
		<div
			class="col-sm-12"
		>
			<k-text-area
				v-model="recipeDirections"
				:placeholder="'Directions'"
			/>
		</div>
	</div>
	<br />
	<div
		class="row"
	>
		<div
			class="col-sm-12"
		>
			<k-text-box
				v-model="recipePhotoUrl"
				:placeholder="'Photo Url'"
			/>
		</div>
	</div>
	<br />
	<div
		class="row"
	>
		<div
			class="col-sm-12"
		>
			<k-button 
				@click="saveRecipe"
			>
				Save
			</k-button>
		</div>
	</div>	
</template>
<style scoped>
	.border {
        border-color: grey;
        border-radius: 25px;
        border-style: solid;
        border-width: 1px;
        padding: 20px;
    }

</style>