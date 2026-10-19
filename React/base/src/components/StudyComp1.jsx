function StudyComp1(props){
  return(
    <>
      <li><a href = "/" onClick={ () => props.onEvent1()}>학습</a></li>
    </>
  )
}

export default StudyComp1