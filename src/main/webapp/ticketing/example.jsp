<%@ page contentType="text/html; charset=UTF-8"%>
<%
	
%>
<!-- HTML code for the number list and arrow buttons -->
<div class="number-list">
  <button class="arrow left">←</button>
  <ul>
    <li>1</li>
    <li>2</li>
    <li>3</li>
    <li>4</li>
    <li>5</li>
  </ul>
  <button class="arrow right">→</button>
</div>

<!-- JavaScript code to handle arrow button clicks -->
<script>
  const list = document.querySelector('.number-list ul');
  const arrows = document.querySelectorAll('.number-list .arrow');
  let selected = 0;
  
  arrows.forEach(arrow => {
    arrow.addEventListener('click', () => {
      if (arrow.classList.contains('left')) {
        selected = Math.max(0, selected - 1);
      } else {
        selected = Math.min(list.children.length - 1, selected + 1);
      }
      const offset = selected * list.children[0].offsetWidth;
      list.style.transform = `translateX(-${offset}px)`;
    });
  });
</script>