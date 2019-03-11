<template>
    <div class="container wrap-ui packages-container content-wrapper">
        <div class="row">
            <div class="col-md-4">
                <div class="responsive-side collapse">
                    <user-overview v-bind:data="auth"></user-overview>
                    <account-navigation></account-navigation>
                    <ad></ad>
                </div>
            </div>
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="content">
                        <div class="panel-body">
                               <form v-on:submit.prevent="submit()" class="form-horizontal form-account" role="form">
                                    <fieldset v-bind:disabled="loading">
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.title !== undefined && errors.title.length }">
                                            <div class="col-sm-12">
                                                <input v-model="service.title" type="text" name="job_title" class="form-control input-sm" placeholder="Title">
                                                <p v-if="errors.title !== undefined" class="help-block">{{ errors.title.join() }}</p>
                                            </div>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.description !== undefined && errors.description.length }">
                                            <div class="col-sm-12">
                                                <textarea v-model="service.description"
                                                        class="form-control input-sm"
                                                        style="height: 100px"
                                                        placeholder="Description"
                                                ></textarea>
                                                <p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                            </div>
                                        </div>
                                        <!--div class="form-group" v-bind:class="{ 'has-error': errors.categories !== undefined && errors.categories.length }">
                                            <div class="col-sm-12">
                                                <div id="categories-bloc">
                                                    <select
                                                            v-model="service.category_id"
                                                            class="input-sm"
                                                            style="margin-bottom: 10px"
                                                    >
                                                        <option v-for="category in categories" v-bind:value="category.id">{{ category.name }}</option>
                                                    </select>
                                                    <p v-if="errors.categories !== undefined" class="help-block">{{ errors.categories.join() }}</p>
                                                </div>
                                            </div>
                                        </div -->
                                        <div class="form-group" v-bind:class="{ 'has-error': ((errors.category_id !== undefined && errors.category_id.length) || (errors.subcategory_id !== undefined && errors.subcategory_id.length)) }">
                                            <div class="col-sm-12">
                                                <category-memu v-bind:categories="categories" v-bind:category-id="service.category_id" v-bind:subcategory-id="service.subcategory_id"></category-memu>
                                                <p v-if="errors.category_id !== undefined" class="help-block">{{ errors.category_id.join() }}</p>
                                                <p v-if="errors.subcategory_id !== undefined" class="help-block">{{ errors.subcategory_id.join() }}</p>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group" v-if="service.galleries.length > 0">
                                            <div class="col-sm-12 gallery-container">
                                                <div v-for="(gallery, index) in service.galleries" >
                                                   <div class="gallery" v-if="gallery.type==='image'">
                                                        <a href="javascript: void(0);" v-on:click="deleteGallery(index)">Delete</a>
                                                        <div class="gallery-image" v-bind:style="{'background-image': getBackgroundImage(gallery.url)}">
                                                        </div>
                                                   </div>
                                                    <div class="gallery" v-if="gallery.type==='video'">
                                                        <a href="javascript: void(0);" v-on:click="deleteGallery(index)">Delete</a>
                                                        <iframe v-bind:src="gallery.embed_url" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
                                                   </div>
                                                </div>
                                            </div>
                                        </div>
                                       <div class="form-group">
                                        <div v-for="(attachment, index) in service.images" class="form-group mb-0">
                                            <div class="row">
                                                <div class="col-md-12" style="margin-left: 15px;">
                                                    <div class="col-xs-6" >
                                                        <div class="form-group"></div>
                                                        <input type="file" @change="uploadAttachment(attachment, $event, index)" />
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <a id="up_0"
                                                        @click="service.images.splice(index, 1)"
                                                        style="padding: 5px 10px;"
                                                        class="delete_up pull-right btn btn-inverse btn-sm"
                                                        value="remove"
                                                        >X</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                         + <a href="javascript:void(0)" @click="service.images.push({})"><u>Add a picture</u></a>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div v-for="(video, index) in service.videos" class="form-group mb-0">
                                            <div class="row">
                                                <div class="col-md-12" style="margin-left: 15px;">
                                                    <div class="col-xs-6" >
                                                        <div class="form-group"></div>
                                                        <input class="form-control input-sm" type="text"  v-model="service.videos[index].filename" placeholder="https://www.youtube.com/watch?v=mx0_pwECCTk"/>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <a id="up_0"
                                                        @click="service.videos.splice(index, 1)"
                                                        style="padding: 5px 10px;"
                                                        class="delete_up pull-right btn btn-inverse btn-sm"
                                                        value="remove"
                                                        >X</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                         + <a href="javascript:void(0)" @click="service.videos.push({})"><u>Add a video</u></a>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.packages !== undefined && errors.packages.length }">
                                            <div class="col-sm-12">
                                                <p v-if="errors.packages !== undefined" class="help-block">{{ errors.packages.join() }}</p>
                                            </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6" v-for="(option, index) in service.packages">
                                            <div class="form-group">
                                                <div class="col-sm-12">
                                                    <div class="col-xs-6">
                                                        Option #{{index + 1}}
                                                    </div>
                                                    <div class="col-xs-6">
                                                        <a class="pull-right" v-if="index !== 0" href="javascript:void(0)" @click="service.packages.splice(index, 1)">delete this option</a>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12" v-bind:class="{ 'has-error': errors['packages.' + index + '.name'] }">
                                                    <input v-model="option.name" type="text" name="option_name" class="form-control input-sm" placeholder="Option name (example: BASIC)">
                                                    <p v-if="errors['packages.' + index + '.name']" class="help-block">{{ errors['packages.' + index + '.name'].join() }}</p>
                                                </div>
                                            </div>
                                            <div class="form-group" v-bind:class="{ 'has-error': errors['packages.' + index + '.description'] }">
                                                <div class="col-sm-12">
                                                    <textarea v-model="option.description"
                                                            class="form-control input-sm"
                                                            style="height: 100px;resize: none;"
                                                            placeholder="Description"
                                                    ></textarea>
                                                    <p v-if="errors['packages.' + index + '.description']" class="help-block">{{ errors['packages.' + index + '.description'].join() }}</p>
                                                </div>
                                            </div>
                                            <div class="form-group" v-bind:class="{ 'has-error': errors['packages.' + index + '.price'] }">
                                                <div class="col-sm-12">
                                                    <input v-model="option.price" type="text" name="option_price" class="form-control input-sm" placeholder="Price (€)">
                                                    <p v-if="errors['packages.' + index + '.price']" class="help-block">{{ errors['packages.' + index + '.price'].join() }}</p>
                                                </div>
                                            </div>
                                           <div class="form-group">
                                                <div class="col-sm-12" v-bind:class="{ 'has-error': errors['packages.' + index + '.days_to_deliver'] }">
                                                    <input v-model="option.days_to_deliver" type="text" name="days_to_deliver" class="form-control input-sm" placeholder="Days to deliver">
                                                    <p v-if="errors['packages.' + index + '.days_to_deliver']" class="help-block">{{ errors['packages.' + index + '.days_to_deliver'].join() }}</p>                                                </div>
                                            </div>
                                            <div class="form-group" v-bind:class="{ 'has-error': errors['packages.' + index + '.number_devisions'] }">
                                                <div class="col-sm-12">
                                                    <input v-model="option.number_devisions" type="text" name="number_devisions" class="form-control input-sm" placeholder="Number of devisions">
                                                    <p v-if="errors['packages.' + index + '.number_devisions']" class="help-block">{{ errors['packages.' + index + '.number_devisions'].join() }}</p> 
                                                </div>
                                            </div>
                                            <div class="form-group" v-bind:class="{ 'has-error': errors['packages.' + index + '.instruction'] }">
                                                <div class="col-sm-12">
                                                    <textarea v-model="option.instruction"
                                                            class="form-control input-sm"
                                                            style="height: 100px;resize: none;"
                                                            placeholder="Instructions for the client"
                                                    ></textarea>
                                                    <p v-if="errors['packages.' + index + '.instruction']" class="help-block">{{ errors['packages.' + index + '.instruction'].join() }}</p> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <a v-if="service.packages.length < 3" class="btn full-width" href="javascript:void(0)" @click="service.packages.push({})">ADD AN OPTION</a>
                                        </div>
                                    </div><br/>
                                     <div class="row">
                                        <div class="col-md-12">
                                           <button class="ns-btn ns-btn-yel" type="submit">
                                            {{isUpdate() ? 'UPDATE THE SERVICE' : 'PUBLISH THE SERVICE'}}
                                            </button>
                                        </div>
                                    </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import accountNavigation from '../../components/account-navigation.vue';
    import ad from '../../components/ad.vue';
    import userOverview from '../../components/user-overview.vue';
    import categoryMenu from '../../components/common/categories.vue';

    export default {
        data() {
            return {
                startups: [],
                loading: true,
                errors: {
                    packages: []
                },
                service: {
                    images: [],
                    packages: [{}, {}],
                    videos: [],
                    galleries: [],
                    category_id: null,
                    subcategory_id: null
                },
                categories: [],
                selectedCategoryIndex: null
            }
        },
        created() {
          this.fetchCategories();
          if (this.isUpdate()) {
              this.getServiceById(this.$route.params.id);
          }

            this.$events.on('selectedCategoryFired', this.updateCategory);
            this.$events.on('selectedSubCategoryFired', this.updateSubCategory);
        },
        computed: {
            auth() {
                return this.$store.getters.user
            }
        },
        components: {
            'ad': ad,
            'account-navigation': accountNavigation,
            'user-overview': userOverview,
            'category-memu': categoryMenu
        },
        methods: {
           fetchCategories() {
                this.$http.get('/api/services/categories').then(response => {
                    this.categories = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            uploadAttachment(attachment, event, index) {
                let file = event.target.files[0] || event.dataTransfer.files[0];
                let data = new FormData;

                data.append('attachment', file);
                this.loading = true;

                this.$http.post('/api/services/gallery/upload', data).then(response => {
                    this.service.images[index].filename = response.body.filename;
                }, response => {
                    alert(response.body.attachment.join());
                    event.target.value = '';
                }).finally(() => {
                    this.loading = false;
                })
            },
            submit() {
                this.loading = true;

                // Update
                if (this.isUpdate()) {
                    for (var i = 0; i < this.service.galleries.length; i++) {
                        var item = this.service.galleries[i];

                        if (item.type==="image") {
                            this.service.images.push(item);
                        } else {
                            this.service.videos.push(item);
                        }
                    }

                    this.service.galleries = [];

                    this.selectedCategoryIndex = this.categories.map(function(x) {return x.id; }).indexOf(this.service.category_id);
                }

                if (this.selectedCategoryIndex === null) {
                    alert('Please select the category.');
                    return;
                }

                 if (this.categories[this.selectedCategoryIndex].subcategories.length > 0 && !this.service.subcategory_id) {
                    alert('Please select the subcategory.');
                    return;
                }

                if (this.service.subcategory_id === 0) {
                    this.service.subcategory_id = null;
                }

                this.$http.post('/api/services/create', this.service).then(response => {
                    this.service = {
                        images: [],
                        packages: [{}, {}],
                        videos: []
                    };
                    
                    this.errors = {
                        packages: []
                    };

                    this.$router.push(`/user/packages`);
                }, response => {
                    this.errors = response.data;
                }).finally(() => {
                    this.loading = false;
                    this.submitting = false;
                })
            },
            getServiceById(id) {
                this.$http.get(`/api/services/by-id/${id}`).then(response => {
                    response.data.images = [];
                    response.data.videos = [];
                    this.service = response.data;
                    this.service.images = [];
                }).finally(() => {
                    this.loading = false;
                });
            },
            getBackgroundImage(path) {
                return `url(${path})`;
            },
            deleteGallery(index) {
                this.service.galleries.splice(index, 1);
            },
            isUpdate() {
                return this.$route.params.id ? true : false;
            },
            updateCategory(index) {
                this.service.category_id = this.categories[index].id;
                this.selectedCategoryIndex = index;
            },
            updateSubCategory(id) {
               this.service.subcategory_id = id;
            }
        }
    }
</script>
<style>
.packages-container .btn-wrapper {
    float: right;
}
.packages-container .create-package-btn {
    width: 100%;
}

.full-width {
     width: 100%;
    background: #e6e6e6;
    color: #1e170c;
}

.packages-container .gallery-container {
    display: flex;
    flex-flow: row wrap;
}

.packages-container .gallery-container .gallery {
    width: 200px;
    height: 150px;
    margin-right: 10px;
}

.packages-container .gallery-container .gallery-image {
    width: 100%;
    height: 100%;
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
}
</style>