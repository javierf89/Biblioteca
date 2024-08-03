

document.addEventListener("DOMContentLoaded", () => {
    fetch('http://localhost:5000//api/books')
        .then(response => {
            if (!response.ok) {
                throw new Error('No responde ' + response.statusText);
            }
            return response.json();
        })
        .then(books => {
            const booksContainer = document.getElementById('books');
            books.forEach(book => {
                const bookElement = document.createElement('div');
                bookElement.className = 'book';

                const img = document.createElement('img');
                img.src = book.image_url;
                img.alt = book.title;
            

                const title = document.createElement('span');
                title.className = 'book-title';
                title.innerText = book.title;

                const button = document.createElement('button');
                button.innerText = 'Prestar';
                button.className="botonPrestar"
                button.addEventListener('click', () => {
                    alert(`Prestar libro: ${book.title}`);
                });

                bookElement.appendChild(img);
                bookElement.appendChild(title);
                bookElement.appendChild(button);

                booksContainer.appendChild(bookElement);
            });
        })
        .catch(error => {
            console.error('error:', error);
        });
});