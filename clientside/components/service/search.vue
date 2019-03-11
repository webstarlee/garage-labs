 <template>
    <div class="panel panel-default" v-show="selectedItem === 'build'">
        <span class="panel-heading btn-block grid-panel-title">
            <span class="ns-icon ns-icon-24">
            <img src="/vendor/img/custom-icon/ic-filter-24.png" alt="">
            </span> {{serviceSearchConfig.title}}
        </span>
        <div class="panel-body">
            <form v-on:submit.prevent="search()">
                <dl class="margin-zero">
                    <div class="form-group">
                      <dt class="panel-subtitle">{{serviceSearchConfig.category}}</dt>
                      <dd>
                          <div id="categories-bloc">
                            <category-memu v-bind:categories="categories" v-bind:category-id="serviceFilters.category_id" v-bind:subcategory-id="serviceFilters.subcategory_id" v-bind:displayServiceCount="true"></category-memu>
                        </div>
                         <!-- a class="panel-link" href="javascript:void(0)" @click="addCategory()">+ Ajouter une compétence </a -->
                      </dd>
                  </div>
                    <div class="form-group">
                        <dt class="panel-subtitle">{{serviceSearchConfig.keyword}}</dt>
                        <dd>
                            <input type="text"
                                    class="form-control input-sm"
                                    placeholder="Mobile, web, .."
                                    v-model="serviceFilters.keyword"
                            />
                        </dd>
                    </div>
                </dl>
                <div class="form-group">
                    <button class="ns-btn ns-btn-yel">
                        {{serviceSearchConfig.search_button}}
                    </button>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
    import categoryMenu from '../../components/common/categories.vue';
    export default {
        props: ['serviceFilters'],
        data() {
          return {
            categories: [],
            selectedCategoryIndex: null,
            serviceSearchConfig: {}
          }
        },
        created() {
            this.fetchContentEn();
            this.fetchCategories();
            this.$events.on('selectedCategoryFired', this.updateCategory);
            this.$events.on('selectedSubCategoryFired', this.updateSubCategory);
        },
        components: {
            'category-memu': categoryMenu
        },
        methods: {
            search() {
                this.$events.emit('serviceFilters');
            },
            fetchCategories() {
                this.$http.get('/api/services/categories').then(response => {
                    this.categories = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            addCategory() {
                this.serviceFilters.categories.push({});
            },
            updateCategory(index) {
                this.serviceFilters.category_id = this.categories[index].id;
                this.selectedCategoryIndex = index;
            },
            updateSubCategory(id) {
               this.serviceFilters.subcategory_id = id;
               this.$events.emit('serviceFilters');
            },
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.serviceSearchConfig = response.body.list_service.search;
                }, response => {
                    console.log(response);
                });
            }
        }
    }
</script>

