> Note: This is not a concrete5-specific issue, but explained in relation to concrete5

The term is quite confusing and we will split it up here in two sub categories

> the same term defines the simple process of externally providing instance variables to a class as it does to the Container object's magical auto-instantiation of object (which also "injects dependencies.")


# Dependency Injection
The term is simple explained, we bring all dependencies of a class through the constructor. As an example let’s say we have this class:

```
<?php

namespace Application\MarinaPortal\Boat;

class BoatLister
{

    public function getBoats()
    {
        $db = \Database::getConnection();
        $r = $db->executeQuery('select * from Boats');
        // Do interesting stuff here...
    }

}
```
Note: Don’t use Loader any more to get the dabase instance it is [deprecated](https://documentation.concrete5.org/developers/appendix/deprecated-code-reference-ongoing).

So here are two “problems” with this class. <br/>
First duplicated code: Every time you need a database instance, you will need to add this line of code `$db = \Database::getConnection();`. <br/>
Second Testability: It’s quit hard to use mockups for this class. If you like to mockup the database you need to figure out how to get the mockup out of the `\Database::getConnection();` function.

So the solution will be to create a single entry point for class dependencies, so our sample class will change to:

```
<?php

namespace Application\MarinaPortal\Boat;

class BoatLister
{

    public function __construct(DatabaseConnection $db)
    {
        $this->db = $db;
    }
    public function getBoats()
    {
        $r = $this->db->executeQuery('select * from Boats');
        // Do interesting stuff here...
    }

    public function getBoatByID($id)
    {
        $r = $this->db->executeQuery('select * from Boats where id = ?', [$id]);
    }
}
```

Now you can use the class like this `$list = new BoatLister(\Database::getConnection());`. It’s not that handy but it solves all the problems descriped above. To make it more coder friendly the next chapter comes in the play where all the magic will happen.


# Automated Dependency Injection using Containers
Thanks to the dependency injection container we don’t need to create an object like here and have to take care about all his dependencies:

```
$list = new BoatLister(\Database::getConnection());
```

The concrete5 container will care about the dependency instances and also for instances of there dependencies and so on. Cause of this we can get the instance really easy like this:

```
$list = $this→app→make(BoatLister::class);
```
or
```
$list = Core::make(BoatLister::class);
```

And there is also a way to use specific dependency instances. Specially when you wanna use some specific mockups for the requested instance. As an example in a test context:

```
$this->app->make(BoatLister::class, ['db' => $mockupInstance]);
```

## How does the container know which instances he has to use
The default behavior of the container is to create automatically a new instance of the dependency classes and passes it to the requested instance (using PHP's Reflection functionality).

But there are also ways to bind specific behavior to the concrete5 container.

Singleton: It will always use the same instance of the class `DatabaseManager`

```
$this->app->singleton('Concrete\Core\Database\DatabaseManager');
```

Interfaces and Extensibility: Binding an interface to a class. So always when this interface is used as a dependency it will get the instance of `EntityManagerConfigFactory` out of the container.

```
$this->app->bind('Concrete\Core\Database\EntityManagerConfigFactoryInterface', 'Concrete\Core\Database\EntityManagerConfigFactory');
```

Or define how the instance should be created when you use it as a dependency.

```
$this->app->bind(PersonResolver::class, function(Application $app) {
    return YourWayToCreateThePersonResolverInstance;
});
```

# Summary
For more informations and my references see the following links:

* http://andrewembler.com/2018/03/concrete-guide-dependency-injection/
* http://andrewembler.com/2018/03/automated-dependency-injection-using-containers/
* https://github.com/lemonbrain-mk/graphql_websocket_sample/pull/7