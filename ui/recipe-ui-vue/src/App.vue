<script>
	import { Button as KButton } from "@progress/kendo-vue-buttons";
	import { DropDownList } from '@progress/kendo-vue-dropdowns';
	import { Window as KWindow } from '@progress/kendo-vue-dialogs';
	import DropDown from './components/DropDown.vue';
	import DropDownTree from './components/DropDownTree.vue';
	import DisplayRecipe from './components/DisplayRecipe.vue';
	import EditItems from './components/EditItems.vue';
	import NewRecipe from './components/NewRecipe.vue';
	import ResultsTable from './components/ResultsTable.vue';	

	export default {
		components: {
			KButton,
			DropDown,
			DropDownList,
			DropDownTree,
			DisplayRecipe,
			EditItems,
			NewRecipe,
			ResultsTable,
            KWindow
        },
		data: function () {
            return {
				domain: 'http://10.1.10.28:3000',
				filterCriteria: {
                    recipeCookTime: null,
					difficultyId: null,
				    tagId: null
				},
				selectedRecipeId: 0,
                showNewRecipeModal: false,
				showDisplayEditModal: false,
				showEditTagsModal: false,
				showEditIngredientsModal: false,
				showEditEquipmentsModal: false
            };
        },
		methods: {
			handleDropDownSelect(data) {
				alert(`${data.dataType} ${data.id}`);
				switch (data.dataType) {
					case 'difficulty':
					    this.filterCriteria.difficultyId = data.id;
					case 'cookTime':
					    this.filterCriteria.cookTime = data.id;
					default:
					    return;
				}
			},
			handleGridRowClick(recipeId) {
				this.selectedRecipeId = recipeId;
				this.toggleDisplayEditModal();
			},
			handleItemSelected(e) {
                this.selectedItemId = e.selectedItemId;
                this.filterCriteria.tagId = e.selectedItemId;
			},
			toggleNewRecipeModal() {
				this.showNewRecipeModal = !this.showNewRecipeModal;
			},
			toggleDisplayEditModal() {
				this.showDisplayEditModal = !this.showDisplayEditModal;
			},
			toggleEditTagsModal() {
				this.showEditTagsModal = !this.showEditTagsModal;
			},
			toggleEditIngredientsModal() {
				this.showEditIngredientsModal = !this.showEditIngredientsModal;
			},
			toggleEditEquipmentsModal() {
				this.showEditEquipmentsModal = ! this.showEditEquipmentsModal;
			}
		}
	};
</script>

<template>
	<div
		class="recipeMain"
	>
		<h1>
			..-recipe-..
		</h1>
		<br />
		<div
			class="controls container"
		>			
			<div
				class="row text-start"
			>
				<div class="row-insert">		
					<div
						class="col-sm-4"
					>
						<drop-down-tree
							:style="{ width: '300px', margin: '0 5px 10px 5px' }"
							:domain="domain"
                            :path="'tag'"
                            @itemSelected="handleItemSelected"
						/>
					</div>
					<div
						class="col-sm-4 no-pad-left"
					>
						<drop-down
							:style="{ width: '300px', margin: '0 5px 10px 5px' }"
							:data-type="'difficulty'"
							:domain="domain"
							:path="'difficulty'"
							@dropDownSelect="handleDropDownSelect"
						/>
					</div>
					<div
						class="col-sm-4 no-pad-left"
					>
						<drop-down
							:style="{ width: '300px', margin: '0 5px 10px 5px' }"
							:data-type="'cookTime'"
							:domain="domain"
							:path="'cookTime'"
							@dropDownSelect="handleDropDownSelect"
						/>
					</div>
				</div>
			</div>
		</div>
		<div
			class="results container"
		>
			<results-table
				:domain="domain"
				:filterCriteria="filterCriteria"
				@gridRowClick="handleGridRowClick"
			/>
		</div>
		<div
			class="edit container"
		>
			<div
				class="row"
			>
				<div
					class="col-sm-3"
				>
					<k-button
						@click="toggleNewRecipeModal"
					>
						New Recipe
					</k-button>
				</div>
				<div
					class="col-sm-3"
				>
					<k-button
						@click="toggleEditTagsModal"
					>
						Edit Tags
					</k-button>
				</div>
				<div
					class="col-sm-3"
				>
					<k-button
						@click="toggleEditIngredientsModal"
					>
						Edit Ingredients
					</k-button>
				</div>
				<div
					class="col-sm-3"
				>
					<k-button
						@click="toggleEditEquipmentsModal"
					>
						Edit Equipment
					</k-button>
				</div>
			</div>
		</div>
		<div
			class="modals"
		>
			<k-window
				v-if="showDisplayEditModal"				
				:initial-width="650"
				:initial-height="700"				
				@close="toggleDisplayEditModal"
			>
				<display-recipe
					:domain="domain"
					:path="`recipe/${selectedRecipeId}`"
				></display-recipe>
			</k-window>
			<k-window
				v-if="showNewRecipeModal"
				:initial-width="600"
				:initial-height="825"
				@close="toggleNewRecipeModal"
			>
				<new-recipe
					:domain="domain"
				></new-recipe>
			</k-window>
			<k-window
				v-if="showEditTagsModal"
				:initial-height="400"
				:initial-width="650"							
				@close="toggleEditTagsModal"
			>
				<edit-items
					:domain="domain"
					:path="'tag'"
				/>
			</k-window>
			<k-window
					v-if="showEditIngredientsModal"
					:initial-height="450"
					:initial-width="650"
					@close="toggleEditIngredientsModal"
			>
				<edit-items
						:domain="domain"
						:path="'ingredient'"
				/>
			</k-window>
			<k-window
					v-if="showEditEquipmentsModal"
					:initial-height="450"
					:initial-width="650"
					@close="toggleEditEquipmentsModal"
			>
				<edit-items
						:domain="domain"
						:path="'equipment'"
				/>
			</k-window>
		</div>
	</div>
</template>

<style scoped>
	.recipeMain {
		text-align: center;

		.controls {
			.row-insert {
				display: flex;
				padding-right: 29px;
			}
		}

		.edit {
			margin-top: 30px;

			button {
				margin: 5px;
				width: 200px;
			}
		}
		
	}
</style>
