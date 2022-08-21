<h1>Comandos utilizados para Blog2</h1>

<h2>Crear 5 Usuarios</h2>

``` 
    usuario = User.new(first_name:"Maria", last_name:"Perez", email_address:"maria@example.com")
    usuario.save 
```
``` 
    usuario = User.new(first_name:"Cristian", last_name:"Lagos", email_address:"cristian@example.com") 
    usuario.save 
``` 
``` 
    usuario = User.new(first_name:"Sthepanie", last_name:"Ross", email_address:"sthepanie@example.com")
    usuario.save 
``` 
```  
    usuario = User.new(first_name:"Richar", last_name:"Galindo", email_address:"richar@example.com")
    usuario.save 
``` 
``` 
    usuario = User.new(first_name:"Jose", last_name:"Veliz", email_address:"jose@example.com")
    usuario.save 
``` 

<h2>Crear 5 blogs</h2>

``` 
    blog = Blog.new(name:"Blog 1", description:"Descripcion del blog")
    blog.save 
```
``` 
    blog = Blog.new(name:"Blog 2", description:"Descripcion del blog2") 
    blog.save 
``` 
``` 
    blog = Blog.new(name:"Blog 3", description:"Descripcion del blog3")
    blog.save 
``` 
```  
    blog = Blog.new(name:"Blog 4", description:"Descripcion del blog4")
    blog.save 
``` 
``` 
    blog = Blog.new(name:"Blog 5", description:"Descripcion del blog5")
    blog.save 
``` 

<h2>Haz que los primeros 3 blogs pertenezcan al primer usuario</h2>

``` 
    (1..3).each do |index|
        Owner.create(blog_id: index, user_id:1)
    end
``` 

<h2>Haz que el cuarto blog que crea pertenezca al segundo usuario.</h2>

``` 
    Owner.create(blog_id:4, user_id:2)
``` 
<h2>Haz que el quinto blog que crea pertenezca al último usuario</h2>

``` 
    Owner.create(blog_id:5, user_id:User.last.id)
``` 

<h2>Haz que el tercer usuario sea el propietario de todos los blogs que se crearon</h2>

``` 
    Blog.all.each do |blog|
        Owner.create(blog: Blog.find(blog.id), user:User.find(3))
    end
``` 

<h2>Haz que el primer usuario cree tres publicaciones para el blog con id = 2. Recuerde que no debe hacer Publicacion.create(usuario: Usuario.first, blog_id: 2), sino algo como Publicacion.create(usuario: Usuario.first, blog: Blog.find(2)). Repito, nunca se debe hacer referencia a las claves foráneas en Rails</h2>

``` 
    (1..3).each do |index|
        Post.create(title:"Publicacion #{index}", content:"Contenido de la publicacion #{index}", user:User.first, blog:Blog.find(2))
    end
``` 

<h2>Haz que el segundo usuario cree 5 publicaciones para el último blog</h2>

``` 
    (1..5).each do |index|
        Post.create(title:"Publicacion #{index}", content:"Contenido de la publicacion #{index}", user:User.find(2), blog:Blog.last)
    end
``` 
<h2>Haz que el tercer usuario cree varias publicaciones en diferentes blogs</h2>

``` 
    (1..10).each do |index|
        Post.create(title:"Publicacion #{index}", content:"Contenido de la publicacion #{index}", user:User.find(3), blog:Blog.find(rand(1..Blog.count)))
    end
``` 

<h2>Haz que el tercer usuario cree 2 mensajes para la primera publicación creada y 3 mensajes para la segunda publicación creada</h2>

``` 
    (1..5).each do |index|
        if(index <=2)
            Message.create(author:"Author #{index}", message:"message #{index} del usuario #{User.find(3).id}", user:User.find(3), post:Post.find(1))
        else
            Message.create(author:"Author #{index}", message:"message #{index} del usuario #{User.find(3).id}", user:User.find(3), post:Post.find(2))
        end
    end
``` 

<h2>Haz que el cuarto usuario cree 3 mensajes para la última publicación que tu creaste</h2>

``` 
    (1..3).each do |index|

        Message.create(author:"Author #{index}", message:"message #{index} del usuario #{User.find(3).id}", user:User.find(4), post:Post.last)
    end
``` 

<h2>Cambie el propietario de la 2 publicación para que sea el último usuario</h2>

```
Post.find(2)
Post.find(2).update({user:User.last})
Post.find(2)
```

<h2>Cambie el contenido de la segunda publicación por algo diferente</h2>

```
Post.find(2)
Post.find(2).update({content:"Contenido cambiado de la publicacion 2"})
Post.find(2)
```

<h2>Obtenga todas las publicaciones que fueron creadas por el tercer usuario</h2>

Dada la aclaración del CodingDojo que dice <i>"Cuando hagas estas actividades, cuando indicamos que queremos obtener todas las publicaciones del Usuario 1, nos estamos refiriendo a todos los blog que son propiedad del Usuario 1 y NO a los blog donde el Usuario 1 ha escrito publicaciones."</i>, el código queda de la siguiente forma:

```
    Blog.joins(:owners).where("owners.user_id = ?", User.find(3))
```

<h2>Obtenga todos los blog que son propiedad del tercer usuario (haz que esto funcione con un simple Usuario.find(3).blogs)</h2>

Para lograr con este objetivo, se extrajo parte del código de la actividad anterior y se tuvo que crear una función que retorne los blogs en el modelo User

```
    def blogs
        Blog.joins(:owners).where("owners.user_id = ?", id)
    end
```

Después de agregar la funcionalidad se debe ingresar a la consola de Ruby y agregar el siguiente comando:

```
    User.find(3).blogs
```

<h2>Obtenga todos los mensajes escritos por el tercer usuario</h2>

```
    User.find(3).messages
```

<h2>Obtenga todas las publicaciones asociadas al blog con id = 5 y quién dejó cada publicación</h2>

```
    Blog.find(5).posts.each do |post|
        puts "#{post.title}, #{post.user.first_name} #{post.user.last_name}"
    end
```

<h2>Obtenga todos los mensajes asociados al blog con id = 5, junto con toda la información de los usuarios que dejaron mensajes</h2>

```
    Message.joins(:post).where("posts.blog_id = ?",5).each do |message|
        puts "-------------------------------------------------------------"
        puts "Author: #{message.author}"
        puts "Message: #{message.message}"
        puts "Usuario ID: #{message.user.id}"
        puts "Usuario nombre: #{message.user.first_name}"
        puts "Usuario apellido: #{message.user.last_name}"
        puts "-------------------------------------------------------------"
    end
```

<h2>Obtenga toda la información de los usuarios que son propietarios del primer blog (haz que esto funcione con un simple Blog.first.propietarios)</h2>

Para que se muestre la información de los propietarios con el comando Blog.first.propietarios, se tuvo que crear una función dentro del modelo Blog tal como se muestra a continuación

```
    def propietarios
        User.joins(:owners).where("owners.blog_id = ?", id)
    end
```

<h2>Cámbielo, es decir, el primer usuario ya no es propietario del primer blog</h2>

```
    Owner.where("user_id = ? and blog_id = ?", User.first.id, Blog.first.id).update_all({user_id:2})
```
