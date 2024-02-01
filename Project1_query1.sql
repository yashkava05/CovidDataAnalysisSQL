SELECT *
FROM SQLProject1..CovidDeaths
ORDER BY 3,4

--SELECT *
--FROM SQLProject1..CovidVaccinations
--ORDER BY 3,4

--SELECTING DATA TO BE USED
SELECT location,date,total_cases,new_cases,total_deaths,population
FROM SQLProject1..CovidDeaths
ORDER BY 1,2

--LIKELIHOOD OF PASSING AWAY FROM COVID
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
FROM SQLProject1..CovidDeaths
WHERE location LIKE '%India'
ORDER BY 1,2

--TOTAL CASES VS POPULATION STUFF
SELECT location,date,total_cases,population,(total_cases/population)*100 AS InfectedPercentage	
FROM SQLProject1..CovidDeaths
--WHERE location LIKE '%India'
ORDER BY InfectedPercentage desc

--HIGHEST INFECTION RATES
SELECT population,location,MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population))*100 AS InfectedPercentage	
FROM SQLProject1..CovidDeaths
--WHERE location LIKE '%India'
GROUP BY location,population
ORDER BY 1,2

--HIGHEST DEATH COUNT PER POPULATION
SELECT location, MAX(cast(Total_deaths as int)) as TotalDeathCount	
FROM SQLProject1..CovidDeaths
--WHERE location LIKE '%India'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount desc

--HIGHEST DEATHS BY CONTINENT
SELECT location, MAX(cast(Total_deaths as int)) as TotalDeathCount	
FROM SQLProject1..CovidDeaths
--WHERE location LIKE '%India'
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount desc

--GLOBAL DAILY DEATH PERCENTAGE
SELECT date,SUM(new_cases),SUM(cast(new_deaths as int)),SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM SQLProject1..CovidDeaths
WHERE continent is not null
GROUP BY 1,2

--
SELECT dths.continent,dths.location,dths.date,dths.population,vcs.new_vaccinations
FROM SQLProject1..CovidDeaths dths
JOIN SQLProject1..CovidVaccinations vcs
	ON dths.location = vcs.location
	and dths.date = vcs.date
WHERE dths.continent IS NOT NULL
ORDER BY 2,3

--Adding new vaccinations per day
SELECT dths.continent,dths.location,dths.date,dths.population,vcs.new_vaccinations,
SUM(CONVERT(int,vcs.new_vaccinations)) over (parti
FROM SQLProject1..CovidDeaths dths
JOIN SQLProject1..CovidVaccinations vcs
	ON dths.location = vcs.location
	and dths.date = vcs.date
WHERE dths.continent IS NOT NULL
ORDER BY 2,3