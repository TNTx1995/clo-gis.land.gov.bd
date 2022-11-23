

const polyline = document.querySelector('#polyline');
      const svg = document.querySelector('#svg');
      svg.addEventListener('click',(e) =>{
          let pts = polyline.getAttribute('points') || '';
          const newPoint = `${e.clientX},${e.clientY} `;
          pts += newPoint;
          polyline.setAttribute('points',pts); 
})

module.exports = {polyline,svg};