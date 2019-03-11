 <template>
    <div class="panel panel-default" v-show="selectedItem === 'build'">
        <span class="panel-heading btn-block grid-panel-title">
            <span class="ns-icon ns-icon-24">
            <img src="/vendor/img/custom-icon/ic-filter-24.png" alt="">
            </span> {{projectSearchConfig.title}}
        </span>
        <div class="panel-body">
            <form v-on:submit.prevent="search()">
                <dl class="margin-zero">
                    <div class="form-group">
                        <dd>
                            <div class="picker picker-checkbox  checked">
                                <div class="picker-handle">
                                    <div class="picker-flag"></div>
                                </div>
                                <label class="checkbox-inline picker-label">
                                    <input class="no-show picker-element"
                                            v-model="projectFilters.type"
                                            value="project"
                                            type="checkbox"
                                    />
                                    <span class="input-sm">{{projectSearchConfig.checkboxProjects}}</span>
                                </label>
                            </div>
                            <div class="picker picker-checkbox  checked">
                                <div class="picker-handle">
                                    <div class="picker-flag"></div>
                                </div>
                                <label class="checkbox-inline picker-label">
                                    <input class="no-show picker-element"
                                            v-model="projectFilters.type"
                                            value="mission"
                                            type="checkbox">
                                    <span class="input-sm">{{ projectSearchConfig.checkboxMissions}}</span>
                                </label>
                            </div>
                        </dd>
                    </div>
                    <div class="form-group">
                        <dt class="panel-subtitle">{{projectSearchConfig.keyword}}</dt>
                        <dd>
                            <input type="text"
                                    class="form-control input-sm"
                                    placeholder="Mobile, web, .."
                                    v-model="projectFilters.keyword"
                            />
                        </dd>
                    </div>
                    <div class="form-group">
                        <dt class="panel-subtitle">{{projectSearchConfig.skill_search}}</dt>
                        <dd>
                            <input type="text"
                                    class="form-control input-sm"
                                    placeholder="All"
                                    v-model="projectFilters.tag"
                            />
                        </dd>
                    </div>
                </dl>
                    <div class="form-group">
                        <button class="ns-btn ns-btn-yel">
                            {{projectSearchConfig.search_button}}
                        </button>
                    </div>
            </form>
        </div>
    </div>
</template>

<script>
    export default {
        props: ['projectFilters'],
        methods: {
            search() {
            this.$events.emit('projectFilters');
            },
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.projectSearchConfig = response.body.list_project.search;
                }, response => {
                    console.log(response);
                });
            }
        },
        created() {
            this.fetchContentEn();
        },
        data() {
            return {
                projectSearchConfig: {}
            }
        }
    }
</script>

