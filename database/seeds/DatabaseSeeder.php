<?php
use App\Tag;
use App\User;
use App\Project;
use App\Category;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Schema::disableForeignKeyConstraints();

        $this->call(UsersSeeder::class);
        $this->call(CountriesSeeder::class);
        $this->call(CitiesSeeder::class);
        $this->call(CategoriesSeeder::class);
        $this->call(ProjectsSeeder::class);
        $this->call(MessagesSeeder::class);
        $this->call(NotificationsSeeder::class);
        $this->call(ProposalsSeeder::class);
        $this->call(DocumentsSeeder::class);
        $this->call(TagsSeeder::class);
        $this->call(FeedbacksSeeder::class);

        Schema::enableForeignKeyConstraints();
    }
}

class UsersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->truncate();

        User::create([
            'username' => 'user',
            'first_name' => 'User',
            'last_name' => 'First',
            'email' => 'user@example.com',
            'password' => bcrypt('password'),
            'phone' => '+1 111 1111',
            'country_id' => 1,
            'city_id' => 1
        ]);

        User::create([
            'username' => 'user2',
            'first_name' => 'User',
            'last_name' => 'Second',
            'email' => 'user2@example.com',
            'password' => bcrypt('password'),
            'phone' => '+2 222 2222',
            'country_id' => 1,
            'city_id' => 1
        ]);

        User::create([
            'username' => 'user3',
            'first_name' => 'User',
            'last_name' => 'Third',
            'email' => 'user3@example.com',
            'password' => bcrypt('password'),
            'phone' => '+3 333 3333',
            'country_id' => 1,
            'city_id' => 1
        ]);

        User::create([
            'username' => 'user4',
            'first_name' => 'User',
            'last_name' => 'Fourth',
            'email' => 'user4@example.com',
            'password' => bcrypt('password'),
            'phone' => '+4 444 4444',
            'country_id' => 1,
            'city_id' => 1
        ]);
    }
}

class MessagesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('messages')->truncate();
    }
}

class CountriesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('countries')->truncate();
        DB::table('countries')->insert([
            ['name' => 'United States of America'],
            ['name' => 'United Kingdom'],
            ['name' => 'France']
        ]);
    }
}

class CitiesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('cities')->truncate();
        DB::table('cities')->insert([
            ['name' => 'Washington', 'country_id' => 1],
            ['name' => 'London', 'country_id' => 2],
            ['name' => 'Paris', 'country_id' => 3],
        ]);
    }
}

class TagsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('tags')->truncate();
        DB::table('tags')->insert([
            ['name' => 'PHP'],
            ['name' => 'Laravel'],
            ['name' => 'Web development'],
            ['name' => 'JavaScript'],
            ['name' => 'Ruby']
        ]);
    }
}

class ProjectsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('projects')->truncate();
        
        $project1 = new Project([
            'author_id' => 1,
            'title' => 'Test project',
            'description' => 'This is test project',
            'payment_method' => 'by day',
            'budget' => 1500,
            'starts_at' => date('Y-m-d', strtotime('+3 days')),
            'ends_at' => date('Y-m-d', strtotime('+1 month')),
            'place' => 'Place',
            'show_email' => true,
            'show_phone' => true,
            'contact_phone' => '+1234556',
            'contact_email' => 'contact@mail.com',
        ]);

        $project2 = new Project([
            'author_id' => 2,
            'title' => 'Test project 2',
            'description' => 'This is test project 2',
            'payment_method' => 'by day',
            'budget' => 3500,
            'starts_at' => date('Y-m-d', strtotime('+2 days')),
            'ends_at' => date('Y-m-d', strtotime('+1 month')),
            'place' => 'Place',
            'show_email' => true,
            'show_phone' => true,
            'contact_phone' => '+1234556',
            'contact_email' => 'contact@mail.com',
        ]);

        $project3 = new Project([
            'author_id' => 2,
            'title' => 'Mission',
            'type' => 'mission',
            'description' => 'This is mission',
            'payment_method' => 'by day',
            'budget' => 3500,
            'starts_at' => date('Y-m-d', strtotime('+3 days')),
            'ends_at' => date('Y-m-d', strtotime('+6 months')),
            'place' => 'Place',
            'show_email' => true,
            'show_phone' => true,
            'contact_phone' => '+1234556',
            'contact_email' => 'contact@mail.com',
        ]);

        $project2->created_at = date('Y-m-d H:i:s', strtotime('-1 hour'));
        $project2->updated_at = date('Y-m-d H:i:s', strtotime('-1 hour'));
        $project1->created_at = date('Y-m-d H:i:s');
        $project1->updated_at = date('Y-m-d H:i:s');

        $project1->save();
        $project2->save();
        $project3->save();

        $category1 = Category::find(1);
        $category2 = Category::find(2);
        $category3 = Category::find(3);

        $project1->categories()->attach($category1);
        $project1->categories()->attach($category2);
        $project2->categories()->attach($category3);

        $project1->tags()->attach(Tag::firstOrCreate(['name' => 'PHP']));
        $project1->tags()->attach(Tag::firstOrCreate(['name' => 'JavaScript']));
        $project1->tags()->attach(Tag::firstOrCreate(['name' => 'Laravel']));

        $project2->tags()->attach(Tag::firstOrCreate(['name' => 'Laravel']));
        $project2->tags()->attach(Tag::firstOrCreate(['name' => 'Web development']));
    }
}

class NotificationsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('notifications')->truncate();
    }
}

class CategoriesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('categories')->truncate();
        DB::table('categories')->insert([
            [
                'name' => 'Web development',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'name' => 'Graphic design',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'name' => 'Mobile development',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]
        ]);
    }
}

class ProposalsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('proposals')->truncate();
    }
}

class DocumentsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('documents')->truncate();
        File::cleanDirectory(public_path('storage'));
    }
}

class FeedbacksSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('feedbacks')->truncate();

        DB::table('feedbacks')->insert([
            [
                'author_id' => '2',
                'receiver_id' => '1',
                'project_id' => '1',
                'message' => 'This is test feedback',
                'rating' => '4',
                'updated_at' => date('Y-m-d H:i:s'),
                'created_at' => date('Y-m-d H:i:s')
            ],
            [
                'author_id' => '1',
                'receiver_id' => '2',
                'project_id' => '2',
                'message' => 'This is test feedback',
                'rating' => '5',
                'updated_at' => date('Y-m-d H:i:s'),
                'created_at' => date('Y-m-d H:i:s')
            ]
        ]);
    }
}