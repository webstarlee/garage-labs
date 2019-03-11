<template>
   <div class="catagory-menu-wrapper">
	<ul class="menu">
		<li class="item8" v-for="(category, index) in categories">
			<a href="javascript:void(0);" v-on:click="showHideSubCategory(index, category.id)" v-bind:class="{ active: categoryId ===  category.id}"><span class="ttl">{{category.name+ (displayServiceCount ? ' ('+category.services_count + ')' : '')}} </span><span class="ttl_arrow" v-if="category.subcategories.length > 0"><</span></a>
			<ul class="subitem-wrapper" v-if="category.subcategories.length > 0" v-show="category.display">
				<li class="subitem" v-for="subcat in category.subcategories">
					<a href="javascript:void(0);" class="subitem-link" v-bind:class="{ active: categoryId ===  category.id && subcategoryId === subcat.id }" v-on:click="onSubItemSelect(subcat.id)">{{subcat.name + (displayServiceCount ? ' ('+subcat.services_count + ')' : '')}} </a>
				</li>
			</ul>
		</li>
	</ul>
</div>
</template>

<script>
    export default {
        props: ['categories', "categoryId", "subcategoryId", "displayServiceCount"],
        data() {
            return {
				selectedIndex: -1
            }
        },
		created() {
		},
        computed: {
        },
        methods: {
			showHideSubCategory(index, id) {
				if (this.categoryId === id) {
					if (this.selectedIndex === -1) {
						this.selectedIndex = this.categories.map(function(x) {return x.id; }).indexOf(this.categoryId);
						this.$events.emit('selectedCategoryFired', this.selectedIndex);
					}

					this.categories[this.selectedIndex].display = !this.categories[this.selectedIndex].display;
					return;
				}

				this.categoryId = id;
				this.subcategoryId = null;
				this.$events.emit('selectedCategoryFired', index);
				this.$events.emit('selectedSubCategoryFired', this.subcategoryId);

				// Close previous open menu
				if (this.selectedIndex >= 0) {
					this.categories[this.selectedIndex].display = false;
				}

				this.selectedIndex = index;
				this.categories[index].display = !this.categories[index].display;
			},
			onSubItemSelect(id) {
				this.subcategoryId = id;
				this.$events.emit('selectedSubCategoryFired', id);
			}
        }
        }
</script>
<style>
.catagory-menu-wrapper .mtt-catagory {
	padding: 10px;
	font-size: 20px;
}

.catagory-menu-wrapper a {
	text-decoration: none;
}
.catagory-menu-wrapper ul, .catagory-menu-wrapper ul ul {
	margin: 0;
	padding: 0;
	list-style: none;
}

.menu {
	width: auto;
	height: auto;
}
.menu > li > a {
	background-color: #f9f9f9;
	border-bottom: 1px solid #c1c1c1;
	width: 100%;
	height: 40px;
	line-height: 40px; 
	
	text-indent: 12px;
	display: block;
	position: relative;
	color: #6a6a6b;
}
.menu ul li a {
	background: #ffffff;
	width: 100%;
	height: 30px;
	line-height: 30px;
	text-indent: 30px;
	display: block;
	position: relative;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: 400;
	color: #2e2e2e;
}
.menu li a img {
	height: 30px;
	width: 30px;
	margin-top: 5px; 
}
.menu li a .ttl {
	margin: 1px 0 0 -5px;
	position: absolute;
}
.menu ul li:last-child a {
	border-bottom: 1px solid #c1c1c1;
}
.menu > li > a:hover, .menu > li > a.active {
	color: #e74c3c;
}
.menu > li > a .ttl_arrow {
	font-family: Tahoma;
	font-size: 14px; 
	font-weight: bold;
	display: inline-block;
	position: absolute;
	right: 20px;
	top: 50%;
	line-height: 20px;
	margin: -10px 0 0 0;
	color: #e75040;
	text-indent: 0;
	text-align: center;
	transition: all 0s ease;
}
.menu > li > a:hover .ttl_arrow, .menu > li a.active .ttl_arrow {
	transform: rotate(-90deg);
}
.menu > li > ul li a:before {
	content: '●';
	font-size: 16px;
	color: #7f8c8d;
	position: absolute;
	width: 1em;
	height: 1em;
	top: 0;
	left: -15px;
}

.menu > li > ul li:hover a, .menu > li > ul li:hover a span, .menu > li > ul li:hover a:before {
	color: #32373D;
}
.menu ul > li > a span {
	font-size: 0.857em;
	display: inline-block;
	position: absolute;
	right: 1em;
	top: 50%; 
	background: #fff;
	border: 1px solid #d0d0d3;
	line-height: 1em;
	height: 1em;
	padding: 3px 4px;
	margin: -8px -5px 0 0;
	color: #878d95;
	text-indent: 0;
	text-align: center;
	-webkit-border-radius: .769em;
	-moz-border-radius: 769em;
	border-radius: 769em;
	text-shadow: 0px 0px 0px rgba(255,255,255,.01);
}

.subitem-link.active {
	color: #e74c3c !important;
}
</style>