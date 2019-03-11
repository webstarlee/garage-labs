<template>
    <div class="panel panel-default">
        <div class="panel-body padding-top padding-top-zero padding-right-zero padding-left-zero">
            <div v-bind:style="`background: url(${ data.cover_path }) no-repeat center center #0088E2;`" class="cover-wall"></div>
            <div class="media media-visible pd-right">
                <input @change="uploadAvatar($event)" id="uploadAvatar" type="file" accept="image/*" style="display:none" />
                <a href="javascript:void(0);" class="btn-block photo-card-live myprofile" @click="openFileDialog()">
                    <img class="border-image-profile img-circle photo-card"
                         alt="Image"
                         v-bind:src="data.avatar_path"
                         width="80"
                         height="80">
                </a>
                <div class="media-body">
                    <h4 class="user-name-profile-card btn-block  text-center">
                        <span class="text-warning">{{ data.first_name }} {{ data.last_name }}</span><br/>
                        <router-link class="myprofile" v-bind:to="`/users/${ data.id }`">
                            <span class="none-overflow">{{ data.username }}</span>
                        </router-link>
                        <br>
                        <font color="green" style="font-size:11px">-</font>
                    </h4>
                </div>
            </div>
            <!-- <ul class="nav list-inline nav-pills btn-block nav-user-profile-wall">
                <li><a href="javascript:void(0)">Projets créés <small class="btn-block sm-btn-size counter-sm">{{ data.projects }}</small></a></li>
                <li><a href="javascript:void(0)">Projets remportés <small class="btn-block sm-btn-size counter-sm">{{ data.proposals_won }}</small></a></li>
                <li><a href="javascript:void(0)">Projets prospectés <small class="btn-block sm-btn-size counter-sm">{{ data.proposals }}</small></a></li>
            </ul> -->
        </div>
    </div>
</template>

<script>
    export default {
        props: ['data'],
        data() {
            return {
                loading: false
            }
        },
        methods: {
            openFileDialog() {
				$('#uploadAvatar').trigger('click');
			},
            uploadAvatar(event) {
				this.loading = true;

				let file = event.target.files[0] || event.dataTransfer.files[0];
				let data = new FormData;

				data.append('file', file);
				this.loading = true;

				this.$http.post('/api/account/update-avatar', data).then(response => {
					this.$store.commit('setUserAvatarPath', response.data.avatar_path);
					this.data.avatar_path = response.data.avatar_path;
				}, response => {
					alert(response.body.file.join());
					event.target.value = '';
				}).finally(() => {
					this.loading = false;
				});
			}
        }
    }
</script>