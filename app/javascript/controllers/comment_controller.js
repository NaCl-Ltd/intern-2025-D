import { Controller } from "@hotwired/stimulus";

const mainCommentSection = document.querySelector('.row'); 

if (mainCommentSection) {
  mainCommentSection.addEventListener('click', (event) => {
    const target = event.target;

    const btn = target.closest('.show-comment-box');
    if (btn) {
      const container = btn.closest('.comment');
      if (container) {
        const commentBox = container.querySelector('.comment-box');
        if (commentBox) {
          commentBox.style.display = commentBox.style.display === 'block' ? 'none' : 'block';
    }
  }
}

    if (target.classList.contains('save-comment')) {
      const container = target.closest('.comment');
      if (container) {
        const commentInput = container.querySelector('.comment-input');
        const commentList = container.querySelector('.comment-list');
        const commentBox = container.querySelector('.comment-box');

        const commentText = commentInput.value.trim();

        if (commentText !== '') {
          const newComment = document.createElement('div');

          const hrElement = document.createElement('hr');
          const textElement = document.createElement('p');
          textElement.textContent = commentText;

          const timeElement = document.createElement('p');
          const now = new Date();
          timeElement.textContent = now.toLocaleString();
          timeElement.style.fontSize = '0.8em';
          timeElement.style.color = '#666';

          newComment.appendChild(hrElement);
          newComment.appendChild(textElement);
          newComment.appendChild(timeElement);

          commentList.prepend(newComment);

          commentInput.value = '';
          commentBox.style.display = 'none';
        }
      }
    }
  });
}
