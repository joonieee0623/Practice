function HobbyComp2({onSetMode}){
  return(
    <>
      <li><a herf = "/test" onClick={event => {
        event.preventDefault()    
        onSetMode('hobby')
      }}>취미</a></li>
    </>
  )
}

export default HobbyComp2