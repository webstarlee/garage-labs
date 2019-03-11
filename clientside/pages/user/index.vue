<template>
	<div class="content-wrapper">
		<div v-if="! loading && found" class="container">
			<div v-if="auth && $route.params.id == owner.id"
				id="editIAmModal"
				class="modal fade editedMemberModal"
				tabindex="-1"
				role="dialog"
				aria-labelledby="myModalLabel"
				aria-hidden="true" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							Edit I Am
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Fermer</span></button>
						</div>
						<div class="modal-body">
							<form v-on:submit.prevent="editIAm()">
								<div class="member-name">
									 <div class="checkbox-wrapper">
                                            <input type="checkbox" value="0" v-model="editUser.iam"  id="finding1" />
                                            <label for="finding1">A provider</label>
                                        </div>
                                        <div class="checkbox-wrapper">
                                            <input type="checkbox" value="1" v-model="editUser.iam" id="finding2" />
                                            <label for="finding2">A entrepreneur</label>
                                        </div>
										<div class="checkbox-wrapper">
                                            <input type="checkbox" value="2" v-model="editUser.iam" id="finding3" />
                                            <label for="finding3">A investisseur</label>
                                        </div>
										<p v-if="errors.iam !== undefined" class="help-block">{{ errors.iam.join() }}</p>
								</div> 
								<div class="member-add">
									<button class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">Update</button>
									<div v-if="loading" class="text-center" style="padding: 10px 0">
										<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
									</div>
								</div>                
							</form>
						</div>
				</div>
			</div>
		</div>
		<div class="panel panel-default col-sm-8 col-sm-offset-2" style="margin-top: 2em; padding-bottom:2em;">
			<div v-if="auth && $route.params.id == owner.id"
				id="editLinkedinModal"
				class="modal fade editedMemberModal"
				tabindex="-1"
				role="dialog"
				aria-labelledby="myModalLabel"
				aria-hidden="true" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							Edit Linkedin
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Fermer</span></button>
						</div>
						<div class="modal-body">
							<form v-on:submit.prevent="editLinkedin()">
								<div class="member-name">
									 	<div class="member-title">
											<label for="portfolio_title">Linkedin URL:</label>
											<input v-model="editUser.linkedin_url" type="text" id="portfolio_linkedin" name="linkedin" class="form-control input-sm" placeholder="Linkedin" />
                                        </div>
										<p v-if="errors.linkedin_url !== undefined" class="help-block">{{ errors.linkedin_url.join() }}</p>
								</div> 
								<div class="member-add">
									<button class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">Update</button>
									<div v-if="loading" class="text-center" style="padding: 10px 0">
										<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
									</div>
								</div>                
							</form>
						</div>
					</div>
				</div>
			</div>
			<div v-if="auth && $route.params.id == owner.id"
				id="editPresentationModal"
				class="modal fade editedMemberModal"
				tabindex="-1"
				role="dialog"
				aria-labelledby="myModalLabel"
				aria-hidden="true" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							Edit Presentation
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Fermer</span></button>
						</div>
						<div class="modal-body">
							<form v-on:submit.prevent="editPresentation()">
								<div class="member-name">
									 	<div class="member-title">
											<label for="presentation">Presentation:</label>
											<textarea v-model="editUser.presentation" id="presentation" name="presentation" class="form-control input-sm" placeholder="Presentation" ></textarea>
                                        </div>
										<p v-if="errors.presentation !== undefined" class="help-block">{{ errors.presentation.join() }}</p>
								</div> 
								<div class="member-add">
									<button class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">Update</button>
									<div v-if="loading" class="text-center" style="padding: 10px 0">
										<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
									</div>
								</div>                
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<div v-if="auth && $route.params.id == owner.id"
				id="editSkillsModal"
				class="modal fade editedMemberModal"
				tabindex="-1"
				role="dialog"
				aria-labelledby="myModalLabel"
				aria-hidden="true" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							Edit Skills
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Fermer</span></button>
						</div>
						<div class="modal-body">
							<form v-on:submit.prevent="editSkills()">
								<div class="form-group">
									<dt class="panel-subtitle">Compétences recherchées</dt>
									<dd>
										<div id="categories-bloc">
											<select v-for="selectedSkill in editUser.skills"
													v-model="selectedSkill.id"
													v-bind:key="selectedSkill.id"
													class="input-sm"
													style="margin-bottom: 10px"
											>
												<option v-for="skill in skills" v-bind:value="skill.id" v-bind:key="skill.id">{{ skill.name }}</option>
											</select>
										</div>
										<a class="panel-link" href="javascript:void(0)" @click="addSkill()">+ Ajouter une compétence </a>
										<p v-if="errors.skills !== undefined" class="help-block">{{ errors.skills.join() }}</p>
									</dd>
								</div>
								<div class="member-add">
									<button class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">Update</button>
									<div v-if="loading" class="text-center" style="padding: 10px 0">
										<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
									</div>
								</div>                
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="row user_infos">
				<div class="col-sm-2 user_picture">
					<img v-if="!user.avatar_path" v:bind:src="/vendor/img/user_avatar.png" alt="">
					<img v-if="user.avatar_path" v-bind:src="user.avatar_path" alt="">
					<div v-if="auth && $route.params.id == owner.id">
						<input @change="uploadAvatar($event)" id="uploadAvatar" type="file" accept="image/*" style="display:none" />
						<a href="javascript:void(0);" @click="openFileDialog()">Upload Avatar</a>
					</div>
				</div>
				<div class="col-sm-10 user_cords">
					<div class="user_name">
						<p>{{user.full_name}}</p>
					</div>
					<div class="user_pseudoname">
						<p>@{{user.username}}</p>
					</div>
					
					<ul class="list-inline">
						<li class="user_adresse">
							<span class="ns-icon ns-icon-16" ><img src="/vendor/img/custom-icon/ic-location.png" alt=""></span>
							{{user.city ? user.city.name : 'N/A'}}
						</li>
						<li class="user_date">Membre depuis le {{user.created_at}}</li>
						<li class="user_linkedin"><a v-bind:href="user.linkedin_url">linkedin</a></li>
						<li v-if="auth && $route.params.id == owner.id">
							<a href="javascript:void(0)" v-on:click="openEditLinkedinModal()">
								<img src="/vendor/img/custom-icon/ic-pencil.png" width="14px" height="14px"/>
							</a> 
						</li>
					</ul>
					<ul class="list-inline user_type">
						<li v-for="item in user.displaying_i_am">{{item}}</li>
						<li v-if="auth && $route.params.id == owner.id">
							<a href="javascript:void(0)" v-on:click.prevent="showEditIAmModal()">
								<img src="/vendor/img/custom-icon/ic-pencil.png" width="14px" height="14px"/>
							</a> 
						</li>
					</ul>
					<ul class="list-inline user_stats">
						<li>14 contacts</li>
						<li>31 followers</li>
					</ul>
					<div class="list-inline suser_presentation">
						<li style="width: 90%"><textarea v-model="user.presentation" readonly="true" class="presentation-area"></textarea></li>
						<li v-if="auth && $route.params.id == owner.id">
							<a href="javascript:void(0)" v-on:click="showEditPresentationModal()">
								<img src="/vendor/img/custom-icon/ic-pencil.png" width="14px" height="14px"/>
							</a> 
						</li>
					</div>
					<br/><br/>
					<ul class="list-inline user_actions">
						<!--li><button class="ns-btn ns-btn-yel">Contacter</button></li -->
						<li v-if="isDisplay"><button class="ns-btn ns-btn-yel">Suivre</button></li>
						<li v-if="isDisplay"><button class="ns-btn ns-btn-yel">Ajouter</button></li>
					</ul>
					<ul class="list-inline user_type">
						<li v-for="skill in user.skills">{{skill.name}}</li>
						<li v-if="auth && $route.params.id == owner.id">
							<a href="javascript:void(0)" v-on:click.prevent="showEditSkillModal()">
								<img src="/vendor/img/custom-icon/ic-pencil.png" width="14px" height="14px"/>
							</a> 
						</li>
					</ul>
				</div>
			</div>

				<div class="row user_startups">
					<div class="col-sm-2 text-center">
						<div class="user_section_title" ><p>Start-ups</p><p class="user_section_nbr">{{user.startups_count}}</p></div>
					</div>
					<div class="col-sm-10">
						<ul class="list-inline user_startups_list">
							<li v-for="startup in user.startups" class="user_startup_item">
								<div class="user_startup_logo">
									<img src="/vendor/img/startup-logo.jpg" alt="">
								</div>
								<div class="user_startup_role">
									<span>{{startup.pivot.role}}</span>
								</div>
								<div class="user_startup_name">
									<span>chez {{startup.title}}</span>
								</div>
								<div class="user_startup_desc">
									<span>{{startup.pivot.description}}</span>
								</div>
							</li>
							
						</ul>
					</div>
				</div>

				<div class="row user_projects">
					<div class="col-sm-2 text-center">
					<div class="user_section_title" ><p>Projets</p><p class="user_section_nbr">{{user.projects_count}}</p></div>
					</div>
					<div class="col-sm-10">
						<div class="user_projects_list">
							<div v-for="project in user.projects" class="user_project_item">
								<div class="user_project_header">
									<span class="user_project_title">{{project.title}}</span>
									<span class="user_project_role">Client</span>
								</div>
								<div class="project-tags">
					                <span class="ns-icon ns-icon-16">
					                    <img src="/vendor/img/custom-icon/ic-tag-16.png" alt="">
					                </span>
					                    <button v-for="tag in project.tags" style="margin-right: 5px;"  class="btn btn-tag btn-xs">{{tag.name}}, </button>
					            </div>
								<div class="project-stats">
									<ul class="list-inline" style="display:inline-block;">
					                    <li>
					                        <span class="ns-icon ns-icon-16">
					                            <img src="/vendor/img/custom-icon/ic-dollar.png" alt="">
					                        </span>
					                        <span>
					                           Budget:  {{project.budget}} €
					                        </span>   
					                    </li>
					                    <li>
					                        <span class="ns-icon ns-icon-16">
					                            <img src="/vendor/img/custom-icon/ic-clock-16.png" alt="">
					                        </span>
					                       {{project.created_at}}
					                    </li>
					                    <li>
					                        <span class="ns-icon ns-icon-16">
					                            <img src="/vendor/img/custom-icon/ic-eye-16.png" alt="">
					                        </span>
					                        {{project.views}} <span v-if="project.views>1">vues</span><span v-else>vue</span>
					                    </li>
					                 </ul>
					                 <span class="user_project_etat">{{project.status}}</span>
								</div>
							</div>

						</div>
					</div>
				</div>

				<div class="row user_portfolio" v-if="user.displaying_i_am.indexOf('A provider') >= 0">
					<div class="col-sm-2 text-center">
						<div class="user_section_title" ><p>Portfolio</p><span class="user_section_nbr">{{user.portfolio_count}}</span></div>
					</div>

					<div class="col-sm-10">

						<div class="text-right" v-if="auth && $route.params.id == owner.id">
							<a href=""
                                   v-on:click.prevent="openAddNewPortfolioModal()"
                                   title="Ajouter un membre title btn"
                                    class="ns-btn ns-btn-yel" style="width:150px; margin:10px auto;">
                                   
                                    <div class="member-name">
                                        <span>Add Portfolio</span>
                                    </div>
                            </a>
                            <div id="addPortfolioModal"
                                 class="modal fade"
                                 tabindex="-1"
                                 role="dialog"
                                 aria-labelledby="myModalLabel"
                                 aria-hidden="true" >

                                <div class="modal-dialog text-left">
                                    <div class="modal-content">

                                        <div class="modal-header">
                                         <div class="text-center" style="display:inline-block;">Ajouter un portfolio</div>
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Fermer</span></button>
                                           
                                        </div>

                                        <div class="modal-body text-left">
                                       
                                            <form v-on:submit.prevent="addPortfolioItem()">
                                            	 	<div class="member-title">
                                            	 	<label for="portfolio_title">Title :</label>
                                                         <input v-model="new_portfolio.title" type="text" id="portfolio_title" name="title" class="form-control input-sm" placeholder="Title ..">
														 <p v-if="errors.title !== undefined" class="help-block">{{ errors.title.join() }}</p>
                                                    </div>
                                                    <div class="member-title">
                                                    	<label for="portfolio_title">Description :</label>
                                                    	<textarea v-model="new_portfolio.description"  name="description" style="width:100%"></textarea>	
														<p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                                    </div>
													<div v-if="new_portfolio.item_path">
														<img v-bind:src="new_portfolio.item_path" width="100%" height="300px" />
													</div>
                                                    <div class="member-title">
                                                    	<label for="portfolio_title">Portfolio :</label>
                                                    	<input  @change="uploadPortfolio($event)"  type="file" name="title" class="form-control input-sm" placeholder="Title ..">
                                                    	<p v-if="errors.image_path !== undefined" class="help-block">{{ errors.image_path.join() }}</p>
													</div>
                                                    <div class="member-add">
                                                        <button class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">Ajouter</button>
                                                    </div>         
                                            </form>
                                        </div>
										<div class="modal-footer text-left" v-if="new_portfolio.id">
											<a href="javascript:void(0)" v-on:click.prevent="deletePortfolio(new_portfolio.id)">Delete</a>
										</div>
                                    </div>
                                 </div>
                            </div>						
						</div>
						<ul class="list-inline user_portfolio_list">
							<li v-for="(item, index) in user.portfolios" class="user_portfolio_item">
								 <ul class="portfolio_title list-inline">
								 	<li>{{item.title}}</li>
									<li v-if="auth && $route.params.id == owner.id">
										<a href="javascript:void(0)" v-on:click="openEditPortfolioModal(item, index)">
											<img src="/vendor/img/custom-icon/ic-pencil.png" width="14px" height="14px"/>
										</a> 
									</li>
								 </ul>
								 <div class="portfolio_file">
								 	<img class="img-responsive" v-bind:src="item.item_path" alt="">
								 </div>
								 <div class="portfolio_description">
								 	<p>{{item.description}}</p>
								 </div>
								 <div class="portfolio_date">{{item.created_at}}</div>
							</li>
							
						</ul>

					</div>
					
				</div>
				
				<!-- Start Feedback -->
				<div class="row user_portfolio">
					<div class="col-sm-2 text-center">
						<div class="user_section_title" ><p>Feedbacks</p><span class="user_section_nbr">{{packageFeedbacks.length + projectFeedbacks.length}}</span></div>
					</div>
					<div class="col-sm-10">
						<div>
							<feedbacks v-bind:feedbacks="packageFeedbacks"></feedbacks>
							<feedbacks v-bind:feedbacks="projectFeedbacks"></feedbacks>
						</div>
					</div>
				</div>
				<!-- End Feedback -->
			</div>

		</div>
		<div v-if="loading" class="text-center" style="padding: 150px 0 250px; font-size: 18px;">
	            <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
	    </div>
		
	</div>
</template>


<script type="text/babel">
	import feedbacks from '../../components/common/feedbacks.vue';

    export default {
        data() {
            return {
                message: {
                    conversation_id: null,
                    text: null,
                    errors: {},
                    sending: false
                },
                conversations: null,
                user: null,
                loading: true,
                found: false,
                fetchingConversations: false,
                new_portfolio_item: {},
                new_portfolio: {},
				isDisplay: false,
				editUser: {
					iam: [], 
					linkedin_url:'', 
					presentation: '',
					skills: []
					},
				errors: {},
				skills: {},
				openingPortfolio: -1,
				packageFeedbacks: [],
				projectFeedbacks: []
            }
        },
        created() {
            setTimeout(() => {
                this.fetch();
				this.fetchSkills();
                this.addSkill();
				this.fetchUserFeedbacks();
            }, 0);
        },
        computed: {
            auth() {
                return this.$store.getters.user;
            },
			owner() {
				return this.$store.getters.user;
			}
        },
        components: {
            'feedbacks': feedbacks
        },
        methods: {
        	addPortfolioItem(){
        		let _data = new FormData(),
					add = true;
        		_data.append('portfolio_item',this.new_portfolio_item);
        		_data.append('user_id',this.$route.params.id);
        		_data.append('title',this.new_portfolio.title);
        		_data.append('description',this.new_portfolio.description);

				if (this.new_portfolio.id) {
					_data.append('id',this.new_portfolio.id);
					add = false;
				} else {
					_data.append('id', '');
				}

				this.errors = {};

				this.$http.post(`/api/portfolio/addToUser/${this.$route.params.id}`, _data).then(response => {
					this.user.portfolios = response.data;
					if (add) {
						this.user.portfolio_count += 1;
					}
					
               		this.new_portfolio = {};
					$('#addPortfolioModal').modal('hide');
					this.new_portfolio_item = null;
					this.openingPortfolio = -1;
				}, response => {
					this.errors = response.body;
					alert(response.body.message);
				}).finally(() => {
					this.loading = false;
				});
        	},
        	uploadPortfolio(event){
        		this.new_portfolio_item = event.target.files[0];
        	},
            sendMessage() {
                this.message.sending = true;

                this.$http.post('/api/messages', {
                    conversation_id: this.message.conversation_id,
                    receiver_id: this.user.id,
                    text: this.message.text
                }).then(() => {
                    let elems = document.getElementsByClassName('modal-backdrop fade in');

                    for(let i = 0; i < elems.length; ++i) {
                        elems[i].parentNode.removeChild(elems[i]);
                    }

                    this.$router.push(`/user/messages/thread/${ this.message.conversation_id }`);
                }, response => {
                    if(response.status === 403) {
                        if(this.message.conversation_id === null) {
                            this.message.errors.conversation_id = ['Choose project'];
                        }
                    } else {
                        this.message.errors = response.data;
                    }
                }).finally(() => {
                    this.message.sending = false;
                });
            },
            fetchConversations() {
                if(this.conversations !== null) {
                    return;
                }

                this.fetchingConversations = true;

                this.$http.get(`/api/conversations?user_id=${ this.$route.params.id }`).then(response => {
                    this.conversations = response.data;
                }, response => {
                    console.log(response);
                }).finally(() => {
                    this.fetchingConversations = false;
                })
            },
            fetch() {
                this.$http.get(`/api/users/${ this.$route.params.id }`).then(response => {
                    this.user = response.data;
                    this.found = true;
                }, response => {
                    console.log(response);
                }).finally(() => {
                    this.loading = false;
                });
            },
			uploadAvatar(event) {
				this.loading = true;

				let file = event.target.files[0] || event.dataTransfer.files[0];
				let data = new FormData;

				data.append('file', file);
				this.loading = true;

				this.$http.post('/api/account/update-avatar', data).then(response => {
					this.$store.commit('setUserAvatarPath', response.data.avatar_path);
					this.user.avatar_path = response.data.avatar_path;
				}, response => {
					alert(response.body.file.join());
					event.target.value = '';
				}).finally(() => {
					this.loading = false;
				});
			},
			openFileDialog() {
				$('#uploadAvatar').trigger('click');
			},
			showEditIAmModal() {
				this.editUser.iam = this.user.i_am.split('_');
				$("#editIAmModal").modal('show');
			},
			editIAm() {
				this.errors = {};
				if (this.editUser.iam.length === 0) {
					alert('You must select at least one item.')
					return false;
				}

				this.$http.post('/api/account/update-iam', {iam: this.editUser.iam}).then(response => {
					this.user.i_am = response.data.i_am;
					this.$store.commit('setUserType', response.data.i_am);
					this.user.displaying_i_am = response.data.displaying_i_am;
					this.editUser.iam = [];
					$("#editIAmModal").modal('hide');
				}, response => {
					alert(response.body);
				}).finally(() => {
					this.loading = false;
				});
			},
			openEditLinkedinModal() {
				this.editUser.linkedin_url = this.user.linkedin_url;
				$("#editLinkedinModal").modal('show');
			},
			editLinkedin() {
				this.errors = {};

				this.$http.post('/api/account/update-linkedin', {linkedin_url: this.editUser.linkedin_url}).then(response => {
					this.user.linkedin_url = response.data;
					$("#editLinkedinModal").modal('hide');
					this.editUser.linkedin_url = '';
				}, response => {
					this.errors = response.body;
				}).finally(() => {
					this.loading = false;
				});
			},
			showEditPresentationModal() {
				this.editUser.presentation = this.user.presentation;
				$("#editPresentationModal").modal('show');
			},
			editPresentation() {
				this.errors = {};

				this.$http.post('/api/account/update-presentation', {presentation: this.editUser.presentation}).then(response => {
					this.user.presentation = response.data;
					$("#editPresentationModal").modal('hide');
					this.editUser.presentation = '';
				}, response => {
					this.errors = response.body;
				}).finally(() => {
					this.loading = false;
				});
			},
			fetchSkills() {
				this.loading = true;
                this.$http.get('/api/skills').then(response => {
                    this.skills = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
          	addSkill() {
            	this.editUser.skills.push({});
          	},
			showEditSkillModal() {
				this.editUser.skills = this.user.skills;
				$("#editSkillsModal").modal('show');
			},
			editSkills() {
				this.errors = {};

				this.$http.post('/api/account/update-skills', {skills:this.editUser.skills}).then(response => {
					this.user.skills = response.data;
					$("#editSkillsModal").modal('hide');
					this.editUser.skills = [];
				}, response => {
					this.errors = response.body;
				}).finally(() => {
					this.loading = false;
				});
			},
			openEditPortfolioModal(portfolio, index) {
				this.new_portfolio = portfolio;
				this.openingPortfolio = index;
				$("#addPortfolioModal").modal('show');
			},
			openAddNewPortfolioModal() {
				this.openingPortfolio = -1;
				this.new_portfolio = {};
				this.new_portfolio_item = null;
				$("#addPortfolioModal").modal('show');
			},
			deletePortfolio(id) {
				this.$http.post('/api/portfolio/deleteFromUser', {id: id}).then(response => {
					if (this.openingPortfolio >= 0) {
						this.user.portfolios.splice(this.openingPortfolio, 1);
						this.user.portfolio_count -= 1;
					}

               		this.new_portfolio = {};
					$('#addPortfolioModal').modal('hide');
					this.new_portfolio_item = null;
					this.openingPortfolio = -1;
				}, response => {
					alert(response.body);
				}).finally(() => {
					this.loading = false;
				});
			},
			fetchUserFeedbacks() {
				this.loading = true;
                this.$http.get(`/api/users/user-feedbacks/${this.$route.params.id}`).then(response => {
                    this.projectFeedbacks = response.data.projectFeedbacks;
					this.packageFeedbacks = response.data.packageFeedbacks;
                }).finally(() => {
                    this.loading = false;
                });
			}
        },
    }
</script>

<style scoped>
	

	/* User Infos*/
	.user_infos .user_picture{
        text-align: center;
        margin-bottom: 6px;
    }
    .user_infos .user_picture > img {
    	display: inline-block;
        border-radius: 50%;
        height:100px;
        width:100px;
    }
    .user_infos p {
    	margin-bottom: 0;
	    line-height: normal;
    }
    .user_infos .user_name > p {
	    font-size: 18px;
	    font-weight: bold;
	    margin-bottom: 0;
	    line-height: normal;
	}
	.user_infos .user_pseudoname > p {
		margin-bottom: 8px;
    color: #585858;
	}
	.user_infos .user_adresse,
	.user_infos .user_date,
	.user_infos .user_linkedin,
	.user_type > li,
	.user_stats > li{
		color: #777777;
		font-size: 12px;
	}
	.user_infos .user_adresse .ns-icon {
		margin-right:0px;
	}
	.user_infos .user_presentation textarea {
		width: 80%;
		padding: 5px;
		padding-left: 0;
		font-size: 14px;
	}
	.user_infos .user_actions .ns-btn {
		padding: 4px 24px;
	}

	/* user startup */
	.user_section_title {
		display: inline-block;
	    width: 90px;
	    text-align: center;
	    margin: 6px auto;
	    border-bottom: 3px solid #ffd700;
	    font-weight: bold;
	    padding-bottom: 10px;
	}
	.user_section_title p {
		margin-bottom:5px;
		line-height: normal;
	}
	.user_startups, .user_projects, .user_infos, .user_portfolio_list{
		margin-top: 2em;
	}
	.user_startups .user_startup_item {
		text-align: center;
    	font-size: 14px;
	}
	.user_project_item {
		border: 2px solid #e6e6e6;
    	padding: 8px;
	}
	.user_project_role,
	.user_project_etat{
		float: right;
    	margin-right: 0px;
	}

	.user_project_item {
		margin-bottom: 14px;
	}
	.user_portfolio_item {
		text-align: center;
	}

	#addPortfolioModal .member-title{
		margin-bottom: 1em;
	}
	#addPortfolioModal .member-title textarea{
		font-size:14px;
		border: 1px solid #b3b3b3;
	}
	#addPortfolioModal .member-add button{
		margin-bottom:0;
	}
	#addPortfolioModal .member-add {
		margin-top:2em;
	}
	
	.checkbox-wrapper label{
		color: #333;
	}

	.presentation-area {
		height: 100px;
		resize: none;
		width: 100%;
		font-size: 12px; 
		color: #777777;
		border: solid 1px #777777;
	}
</style>