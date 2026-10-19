/*function ChildComp(props){
  return(
    <>
      <p>
        {props.p1}, {props.p2}, {props.p3}, {props.p4},
      </p>
    </>
  )
}*/

/*function ChildComp({p1, p2, p3, p4}){     //구조분해할당
return(
    <>
      <p>
        {p1}, {p2}, {p3}, {p4},
      </p>
    </>
  ) 
}*/

function ChildComp({p1, p3}){     //(선택적)구조분해할당
return(
    <>
      <p>
        {p1}, {p3}
      </p>
    </>
  ) 
}

function App(){
  const version = 3
  return (
  <>
    <h2>React-프롭스2(props값들의 형태)</h2>
    <ChildComp p1={'Python'} p2={'Maria' +(10+2)} p3={version} p4={`CSS${version}`}></ChildComp>
  </>
  )
}

export default App