<template>
    <div v-if="orderedPackages.length">
        <div class="package-container package-header">
            <ul class="list-inline">
                <li class="id">ID</li>
                <li class="title">Order</li>
                <li class="service-title">Service Title</li>
                <li class="service-supplier">Supplier</li>
                <li class="package-price">Price</li>
                <li class="expecting-date">Expecting on</li>
                <li class="status">Order status</li>
            </ul>
        </div>
        <div v-for="(orderedPackage, index) in orderedPackages">
            <package-li v-bind:orderedPackage="orderedPackage"></package-li>
        </div>
    </div>
</template>

<script>
    import packageLi from './ordered-li.vue';
    export default {
        props: ['orderedPackages'],
        components: {
            'package-li': packageLi
        },
        methods: {
        }
    }
</script>