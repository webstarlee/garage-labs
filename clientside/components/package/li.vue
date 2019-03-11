<template>
    <div>
        <div class="panel container package-container" v-for="(service, index) in services">
            <div class="panel-header">
                <div class="project-stats">
                    <ul class="list-inline">
                        <li class="title">
                            {{service.title}}
                        </li>
                        <li class="option">
                            {{service.number_packages + (service.number_packages > 1 ? ' OPTIONS' : ' OPTION')}}
                        </li>
                        <li class="action">
                        <router-link v-bind:to="`/service/edit/${service.id}`" class="edit"><i class="fa fa-pencil" aria-hidden="true"></i></router-link>
                        <a href="javascript:void(0);" v-on:click="deleteItem(service.id, index)" class="delete"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                        </li>
                    </ul>
                </div>
            </div>   
        </div>
    </div>
</template>

<script>
    export default {
        props: ['services'],
        methods: {
            deleteItem(id, index) {
                if (!confirm("Are you sure want to delete this item?")) {
                    return;
                }

                this.loading = true;

                this.$http.post('/api/services/delete', {id: id}).then(response => {
                    this.services = this.services.splice(index, 1);
                }, error => {
                    console.log(error);
                    alert(response.data);
                }).finally(() => {
                    this.loading = false;
                });
            }
        }
    }
</script>
<style>
.package-container {
    padding-left: 18px;
}

.package-container .option {
    width: 25%;
}

.package-container .title {
    width: 50%;
}

.package-container .action {
    float: right;
    text-align: center;
    font-size: 1.2em;
}

.package-container .action .edit {
    margin-right: 10px;
}

@media (min-width: 576px) {
    .package-container .title {
        width: 75%;
    }

    .package-container .option {
        width: 15%;
    }
}
</style>