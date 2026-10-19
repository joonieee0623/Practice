function StudyComp(props){
  const rows = []
  for(let i=0; i<props.data1.length; i++){
    rows.push(<li>{props.data1[i]}</li>)
  }
  return(<>
    <li>{props.title}</li>
      <ul>
        {rows}
      </ul>
  </>)
}

function HobbyComp(props){
  const rows = []
  for(let i=0; i<props.data2.length; i++){
    rows.push(<li>{props.data2[i]}</li>)
  }
  return(<>
    <li>{props.title}</li>
      <ul>
        {rows}
      </ul>
  </>)
}

let FormComp = () => { 
  return(
  <>
    <form>
      <select name="gubun">
        <option value="study">학습</option>
        <option value="hobby">취미</option>
      </select>
      <input type="text" name="title"/>
      <input type="submit" value="추가"/>
    </form>
  </>
  )
}

function App(){
  const sDatas = ['Python', 'Maria', 'Django', 'React']
  const hDatas = ['수영', '헬스', '여행', '주짓수']
  return (
  <>
    <h2>React-프롭스1</h2>
    <ol>
      <StudyComp title="학습" data1={sDatas}/>
      <HobbyComp title="취미" data2={hDatas}/>
      <FormComp/>
    </ol>
  </>
  )
}

export default App