<?php

Route::group(['prefix' => 'countries'], function()
{
    Route::get('/', 'CountryController@index');
    Route::get('/{countryId}/cities', 'CountryController@cities');
});

Route::group(['prefix' => 'auth'], function()
{
    Route::post('login', 'AuthController@login');
    Route::post('register', 'AuthController@register');
});

Route::group(['prefix' => 'account'], function()
{
    Route::get('/', 'AccountController@get');
    Route::get('projects', 'ProjectController@forUser');
    Route::post('update', 'AccountController@update');
    Route::post('update-avatar', 'AccountController@updateAvatar');
    Route::post('update-cover', 'AccountController@updateCover');
    Route::post('update-password', 'AccountController@updatePassword');
    Route::post('company', 'AccountController@updateCompany');
    Route::post('bank', 'AccountController@updateBankInfo');
    Route::get('startups', 'StartUpController@forUser');
    Route::get('company', 'AccountController@getCompany');
    Route::get('bank', 'AccountController@getBank');
    Route::post('update-iam', 'AccountController@updateIAm');
    Route::post('update-linkedin', 'AccountController@updateLinkedin');
    Route::post('update-presentation', 'AccountController@updatePresentation');
    Route::post('update-skills', 'AccountController@updateSkills');
});

Route::group(['prefix' => 'users'], function()
{
    Route::get('user-feedbacks/{id}', 'UserController@getFeedbacks');
    Route::get('cofounders', 'UserController@getCofounders');
    Route::get('byemail/{email}', 'UserController@byEmail');
    Route::get('ratting/{id}', 'UserController@getUserRatting');
    Route::get('/credit-cards', 'UserController@getCreditCardsOfUser');
    Route::get('{id}/rating', 'UserController@rating');
    Route::get('{id}/references', 'ReferenceController@byUserId');
    Route::get('{id}/feedbacks', 'FeedbackController@byUserId');
    Route::get('{id}/projects', 'ProjectController@byUserId');
    Route::get('{id}', 'UserController@show');
});

Route::group(['prefix' => 'cofounders'], function()
{
    Route::get('/', 'UserController@getCofounders');
});

Route::group(['prefix' => 'references'], function()
{
    Route::get('{id}', 'ReferenceController@show');
    Route::post('/', 'ReferenceController@store');
    Route::post('{id}/update', 'ReferenceController@update');
    Route::post('{id}/delete', 'ReferenceController@delete');
    Route::get('{id}/documents', 'ReferenceController@documents');
});

Route::group(['prefix' => 'documents'], function()
{
    Route::post('/', 'DocumentController@store');
});

Route::group(['prefix' => 'messages'], function()
{
    Route::get('unread', 'MessageController@unread');
    Route::get('threads', 'MessageController@threads');
    Route::get('thread/{id}', 'MessageController@conversation');
    Route::get('startup-thread/{id}', 'ContactController@conversation');
    Route::get('service', 'MessageController@serviceMessages');
    Route::get('startups', 'MessageController@startupMessages');

    Route::post('startup', 'ContactController@storeMessage');
    Route::post('/', 'MessageController@store');
    Route::post('{id}/read', 'MessageController@read');
});

Route::group(['prefix' => 'notifications'], function()
{
    Route::get('/', 'NotificationController@index');
    Route::get('all', 'NotificationController@getNotifications');
    Route::get('unread', 'NotificationController@unread');
    Route::post('read', 'NotificationController@read');
    Route::post('remove', 'NotificationController@deleteNotification');
});

Route::group(['prefix' => 'categories'], function()
{
    Route::get('/', 'CategoryController@index');
    Route::get('/startups', 'CategoryController@getStartUpCategories');
});

Route::group(['prefix' => 'skills'], function()
{
    Route::get('/', 'SkillController@index');
});

Route::group(['prefix' => 'projects'], function()
{
    Route::get('/', 'ProjectController@index');
    Route::get('applied', 'ProjectController@applied');
    Route::get('{slug}', 'ProjectController@bySlug');
    Route::get('{id}/documents', 'DocumentController@forProject');
    Route::get('{id}/proposals', 'ProposalController@forProject');

    Route::post('/check-1', 'ProjectController@checkFirst');
    Route::post('/check-2', 'ProjectController@checkSecond');
    Route::post('/create', 'ProjectController@store');
    Route::post('{id}/update', 'ProjectController@update');
});

// Route::group(['prefix' => 'services'], function()
// {
//     Route::get('/', 'ServiceController@index');
//     Route::get('applied', 'ServiceController@applied');
//     Route::get('{slug}', 'ServiceController@bySlug');
//     Route::get('{id}/documents', 'DocumentController@forProject');
//     Route::get('{id}/proposals', 'ProposalController@forProject');

//     Route::post('/check-1', 'ServiceController@checkFirst');
//     Route::post('/check-2', 'ServiceController@checkSecond');
//     Route::post('/create', 'ServiceController@store');
//     Route::post('{id}/update', 'ServiceController@update');
// });

Route::group(['prefix' => 'startups'], function()
{
    Route::get('/', 'StartUpController@index');
    Route::get('/investor', 'StartUpController@searchForInvestor');
    Route::get('applied', 'StartUpController@applied');
    Route::post('/check-1', 'StartUpController@checkFirst');
    Route::post('/create', 'StartUpController@store');
    Route::get('{slug}', 'StartUpController@bySlug');
    Route::post('{id}/update', 'StartUpController@update');
    Route::post('/invite', 'StartUpController@checkInvitation');
    Route::post('/logo/upload', 'StartUpController@uploadDocument');
    Route::post('/documents', 'StartUpController@uploadMessageDocument');
});

Route::group(['prefix' => 'proposals'], function()
{
    Route::get('{id}', 'ProposalController@show');
    Route::get('conversation/{id}', 'ProposalController@byConversationId');
    Route::get('milestone/card', 'ProposalController@getCardId');
    Route::get('milestone/no/{id}', 'ProposalController@getMilestoneNo');
    Route::get('milestone/management/{id}', 'ProposalController@loadMilestones');
    Route::get('milestone/owner/management/{id}', 'ProposalController@loadOwnerMilestones');
    
    Route::post('milestone/accept', 'ProposalController@acceptMilestone');
    Route::post('milestone/delivery', 'ProposalController@deliveryMilestone');
    Route::post('milestone/approve', 'ProposalController@approveMilestone');
    Route::post('milestone/revision', 'ProposalController@askRevision');
    // Route::get('milestone/storage/{id}/{filename}', 'ProposalController@downloadFile');
    Route::post('milestone/document/upload', 'ProposalController@uploadDocument');
    Route::post('/', 'ProposalController@store');
    Route::post('{id}/update', 'ProposalController@update');
    Route::post('{id}/accept', 'ProposalController@accept');
    Route::post('{id}/modify-offer', 'ProposalController@modifyOffer');
    Route::post('{id}/milestone/payment', 'ProposalController@fundMilestone');
    Route::post('{id}/milestone/save', 'ProposalController@saveMilestone');

    // Route::post('{id}/approve', 'ProposalController@approve');
});

Route::group(['prefix' => 'feedbacks'], function()
{
    Route::post('proposal', 'FeedbackController@storeProjectFeedback');
    Route::post('/', 'FeedbackController@store');
});

Route::group(['prefix' => 'tags'], function()
{
    Route::post('/', 'TagController@store');
    Route::get('search', 'TagController@search');
});

Route::group(['prefix' => 'conversations'], function()
{
    Route::get('/', 'MessageController@conversations');
});

Route::group(['prefix' => 'contacts'], function()
{
    Route::get('/{id}', 'ContactController@show');
    Route::get('conversation/{id}', 'ContactController@byContactId');
    Route::post('/save', 'ContactController@store');
});

Route::group(['prefix' => 'fonds'], function()
{
    Route::get('/', 'FondsController@index');
    Route::get('/{id}', 'FondsController@fondsById');
});

Route::group(['prefix' => 'team'], function(){
    Route::post('addMember','TeamController@addTeamMember');
    Route::post('editMember','TeamController@editTeamMember');
    Route::post('deleteMember','TeamController@deleteMember');
    Route::post('joinTeam','TeamController@joinTeam');
});

Route::group(['prefix' => 'portfolio'], function(){
   Route::post('addToUser/{user_id}', 'PortfolioController@addItem');
   Route::get('byUser/{user_id}', 'PortfolioController@byUser');
   Route::post('deleteFromUser', 'PortfolioController@deleteItem');
});

Route::group(['prefix' => 'services'], function()
{
    Route::get('categories', 'ServiceController@loadCategories');
    Route::get('/', 'ServiceController@index');
    Route::get('my-services', 'ServiceController@getMyServices');
    Route::get('by-id/{id}', 'ServiceController@getServiceById');
    Route::get('package/{id}', 'ServiceController@getPackageById');
    Route::get('ordered-packages', 'ServiceController@getMyOrderedPackages');
    Route::get('sold-packages', 'ServiceController@getMySoldPackages');
    Route::get('ordered-package/{id}', 'ServiceController@getPackageOrderById');
    Route::get('messages/{id}', 'ServiceController@conversation');

    Route::post('gallery/upload', 'ServiceController@uploadDocument');
    Route::post('create', 'ServiceController@create');
    Route::post('delete', 'ServiceController@delete');
    Route::post('payment', 'ServiceController@doPayment');
    Route::post('package/document/upload', 'ServiceController@uploadInstructionDocument');
    Route::post('package/instruction', 'ServiceController@addInstruction');
    Route::post('package/document/delivery', 'ServiceController@uploadDeliveryDocument');
    Route::post('package/delivery', 'ServiceController@deliveryPackage');
    Route::post('package/delivery/approve', 'ServiceController@approveDelivery');
    Route::post('package/feedback', 'ServiceController@feedback');
    Route::post('package/document/revision', 'ServiceController@uploadRevisionDocument');
    Route::post('package/revision', 'ServiceController@submitAskRevision');
    Route::post('messages', 'ServiceController@storeMessage');
});

Route::group(['prefix' => 'customer-support'], function(){
    Route::post('/', 'SupportController@submit');
    Route::post('/fundraising', 'SupportController@submitFundraising');
 });
 