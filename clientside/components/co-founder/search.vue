 <template>
    <div class="panel panel-default">
      <span class="panel-heading btn-block grid-panel-title">
          <span class="ns-icon ns-icon-24">
            <img src="/vendor/img/custom-icon/ic-filter-24.png" alt="">
          </span> {{cofounderSearchConfig.title}}
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
                                          v-model="cofounderFilters.i_am"
                                          value="2"
                                          type="checkbox"
                                  />
                                  <span class="input-sm">{{cofounderSearchConfig.checkboxInvestor}}</span>
                              </label>
                          </div>
                          <div class="picker picker-checkbox  checked">
                              <div class="picker-handle">
                                  <div class="picker-flag"></div>
                              </div>
                              <label class="checkbox-inline picker-label">
                                  <input class="no-show picker-element"
                                          v-model="cofounderFilters.i_am"
                                          value="1"
                                          type="checkbox">
                                  <span class="input-sm">{{cofounderSearchConfig.checkboxProvider}}</span>
                              </label>
                          </div>
                      </dd>
                  </div>
                  <div class="form-group">
                      <dt class="panel-subtitle">{{cofounderSearchConfig.skill_search}}</dt>
                      <dd>
                          <div id="categories-bloc">
                            <select v-for="startup_skills in cofounderFilters.skills"
                                    v-model="startup_skills.id"
                                    v-bind:key="startup_skills.id"
                                    class="input-sm"
                                    style="margin-bottom: 10px"
                            >
                                <option v-for="skill in skills" v-bind:value="skill.id" v-bind:key="skill.id">{{ skill.name }}</option>
                            </select>
                        </div>
                         <a class="panel-link" href="javascript:void(0)" @click="addSkill()">+ {{cofounderSearchConfig.add_skill_link}}</a>
                      </dd>
                  </div>
              </dl>
              <div class="form-group">
                  <button class="ns-btn ns-btn-yel">
                    {{cofounderSearchConfig.search_button}}
                  </button>
              </div>
          </form>
      </div>
  </div>
</template>

<script>
    export default {
        props: ['cofounderFilters'],
        data() {
          return {
            skills: [],
            cofounderSearchConfig: {}
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
                this.cofounderFilters.skills.push({});
          },
          search() {
            this.$events.emit('cofounderFilters');
          },
        fetchContentEn() {
            this.$http.get('/data/content_en.json').then(response => {
                this.cofounderSearchConfig = response.body.list_cofounder.search;
            }, response => {
                console.log(response);
            });
        }
        }
    }
</script>