 <template>
    <div class="panel panel-default">
      <span class="panel-heading btn-block grid-panel-title">
          <span class="ns-icon ns-icon-24">
            <img src="/vendor/img/custom-icon/ic-filter-24.png" alt="">
          </span> {{startupSearch.title}}
      </span>
      <div class="panel-body">
          <form v-on:submit.prevent="search()">
              <dl class="margin-zero">
                <div class="form-group">
                        <dt class="panel-subtitle">{{startupSearch.keyword}}</dt>
                        <dd>
                           <dd>
                                    <input type="text" class="form-control input-sm"  />
                                </dd>
                        </dd>
                    </div>
                  <div class="form-group">
                      <dd>
                          <div class="picker picker-checkbox  checked">
                              <div class="picker-handle">
                                  <div class="picker-flag"></div>
                              </div>
                              <label class="checkbox-inline picker-label">
                                  <input class="no-show picker-element"
                                          v-model="startupFilters.project_status"
                                          value="1"
                                          type="checkbox">
                                  <span class="input-sm">{{startupSearch.checkbox_label_0}}</span>
                              </label>
                          </div>
                           <div class="picker picker-checkbox  checked">
                              <div class="picker-handle">
                                  <div class="picker-flag"></div>
                              </div>
                              <label class="checkbox-inline picker-label">
                                  <input class="no-show picker-element"
                                          v-model="startupFilters.project_status"
                                          value="2"
                                          type="checkbox">
                                  <span class="input-sm">{{startupSearch.checkbox_label_1}}</span>
                              </label>
                          </div>
                           <div class="picker picker-checkbox  checked">
                              <div class="picker-handle">
                                  <div class="picker-flag"></div>
                              </div>
                              <label class="checkbox-inline picker-label">
                                  <input class="no-show picker-element"
                                          v-model="startupFilters.project_status"
                                          value="3"
                                          type="checkbox">
                                  <span class="input-sm">{{startupSearch.checkbox_label_2}}</span>
                              </label>
                          </div>
                          <div class="picker picker-checkbox  checked">
                              <div class="picker-handle">
                                  <div class="picker-flag"></div>
                              </div>
                              <label class="checkbox-inline picker-label">
                                  <input class="no-show picker-element"
                                          v-model="startupFilters.project_status"
                                          value="4"
                                          type="checkbox">
                                  <span class="input-sm">{{startupSearch.checkbox_label_3}}</span>
                              </label>
                          </div>
                      </dd>
                  </div>
                  <div class="form-group">
                      <dt class="panel-subtitle">{{startupSearch.skill_search}}</dt>
                      <dd>
                          <div id="categories-bloc">
                            <select v-for="startup_skills in startupFilters.skills"
                                    v-model="startup_skills.id"
                                    v-bind:key="startup_skills.id"
                                    class="input-sm"
                                    style="margin-bottom: 10px">
                                <option v-for="skill in skills" v-bind:value="skill.id" v-bind:key="skill.id">{{ skill.name }}</option>
                            </select>
                        </div>
                       <a class="panel-link" href="javascript:void(0)" @click="addSkill()">+ {{startupSearch.add_skill_link}}</a>
                      </dd>
                  </div>
              </dl>
              <div class="form-group">
                  <button class="ns-btn ns-btn-yel">
                      {{startupSearch.search_button}}
                  </button>
              </div>
          </form>
      </div>
  </div>
</template>

<script>
    export default {
        props: ['startupFilters'],
        data() {
          return {
            skills: [],
            startupSearch: {}
          }
        },
        created() {
          this.fetchSkills();
          this.addSkill();
          this.fetchContentEn();
        },
        methods: {
            fetchSkills() {
                this.$http.get('/api/skills').then(response => {
                    this.skills = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            addSkill() {
                    this.startupFilters.skills.push({});
            },
            search() {
                this.$events.emit('startUpFilters');
            },
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.startupSearch = response.body.list_startup.search;
                }, response => {
                    console.log(response);
                });
            }
        }
    }
</script>

