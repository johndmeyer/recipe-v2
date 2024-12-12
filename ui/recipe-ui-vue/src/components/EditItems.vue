<script>
    import { Button as KButton } from '@progress/kendo-vue-buttons';
    import { 
        Switch as KSwitch,
        TextBox as KTextBox
    } from "@progress/kendo-vue-inputs";
    import DropDownTree from './DropDownTree.vue';
    
    export default {
        props: [
            'domain',
            'path'
        ],
        components: {
            DropDownTree,
            KButton,
            KSwitch,
            KTextBox
        },
        computed: {
            treeData () {
                return processTreeData(this.dataItems, { expanded: this.expanded, value: this.value }, fields);
            }
        },
        data: function() {
            return {
                checked: true,
                selectedItemId: undefined
            }
        },
        emits: [],
        methods: {
            itemSelected (e) {
                this.selectedItemId = e.selectedItemId;
            },
            saveParent (e) {
                e.preventDefault();

                const data = {};

                data[`${this.path}Description`] = this.parentDescription;

				fetch(`${this.domain}/${this.path}/${this.parent}`, {
					method: 'put',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
				})
			},
            saveUpdateChild (e) {
                e.preventDefault();

                const data = {};

                data[`${this.path}Description`] = this.childDescription;

                if (this.checked) {
                    fetch(`${this.domain}/${this.path}/${this.selectedItemId}/${this.child}`, {
                        method: 'put',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(data)
                    });
                } else {
                    fetch(`${this.domain}/${this.path}/${this.selectedItemId}/${this.child}`, {
                        method: 'post',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(data)
                    });
                }				
            }
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
            <h3>{{ `Add / Edit ${this.path}s` }}</h3>
        </div>
        <br />
        <form
            class="border"
            @submit="saveParent"
        >
            <div
                class="row"
            >
                <div
                    class="col-sm-5 text-start"
                >
                    {{ `New top level ${this.path}` }}
                </div>
                <div
                    class="col-sm-5"
                >
                    <k-text-box
                        v-model="parent"
                    />
                </div>
                <div
                    class="col-sm-2"
                >
                    <k-button
                        type="submit"
                    >
                        Save
                    </k-button>
                </div>
            </div>
            <br />
            <div
                class="row"
            >
                <div
                    class="col-sm-12"
                    v-if="this.path === 'ingredient' || this.path === 'equipment'"
                >
                    <k-text-box
                            v-model="parentDescription"
                    />
                </div>
            </div>
        </form>
        <br />
        <div
            class="border"
        >
            <div
                class="row"
            >
                <div
                    class="col-sm-10"
                >
                    <k-switch
                        :checked="checked"
                        :default-checked="true"
                        :style="{ width: '100%' }"
                        :on-label="`Add a child ${this.path} to this ${this.path} group`"
                        :off-label="`Update this ${this.path} to the new value specified`"
                        
                        @change="(e) => this.checked = !this.checked"
                    />
                </div>
                <div
                    class="col-sm-2"
                >
                </div>                
            </div>
            <form
                @submit="saveUpdateChild"
            >            
                <br />
                <div
                    class="row"
                >
                    <div
                        class="col-sm-5"
                    >                    
                        <DropDownTree
                            :domain="domain"
                            :path="path"
                            @itemSelected="itemSelected"
                        />
                    </div>
                    <div
                        class="col-sm-5"
                    >
                        <k-text-box
                            v-model="child"
                        />
                    </div>
                    <div
                        class="col-sm-2"
                    >
                        <k-button
                            type="submit"
                        >
                            Save
                        </k-button>
                    </div>
                </div>
                <br />
                <div
                    class="row"
                >
                    <div
                        class="col-sm-12"
                        v-if="this.path === 'ingredient' || this.path === 'equipment'"
                    >
                        <k-text-box
                            v-model="childDescription"
                        />
                    </div>
                </div>
            </form>
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