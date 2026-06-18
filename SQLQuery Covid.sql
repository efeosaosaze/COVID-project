select


select location,date,total_cases,new_cases,total_deaths,population
from CovidDeaths
order by 3,4

-- Looking at total cases vs total deaths; the likelhood of death when contracted with the virus
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percentage
from CovidDeaths
where location like '%nigeria%'
order by 1,2

-- looking at what percentage of the population had covid
select location,date,total_cases,population,(total_cases/population)*100 as population_percentage
from CovidDeaths
--where location like '%states%'
order by 1,2

--looking at countries with the highrst infection rate compared to population
 select location,population,max(total_cases) as highest_infection_count,max((total_deaths/population))*100 as percent_population_infected
from CovidDeaths
group by location,population
order by percent_population_infected desc

--looking at the coutries with the highest death count per population
select location,population,max(cast(total_deaths as int)) as total_death_count
from [Portfolio Project]..CovidDeaths
where continent is not null
group by location,population
order by total_death_count desc

Select*
from [Portfolio Project]..CovidDeaths dea
join [Portfolio Project]..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date

--Tableau Presentation
--1
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

--2
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc

--3
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

--4
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc



