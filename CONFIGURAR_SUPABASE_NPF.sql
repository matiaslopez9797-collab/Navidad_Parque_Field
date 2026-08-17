-- Navidad Parque Field - configuración inicial de Supabase
-- Ejecutar una sola vez desde Supabase > SQL Editor > New query > Run

create table if not exists public.npf_workspace (
  id integer primary key,
  data jsonb not null default '{"projects":[],"tasks":[],"members":[]}'::jsonb,
  updated_at timestamptz not null default now(),
  constraint npf_workspace_single_row check (id = 1)
);

alter table public.npf_workspace enable row level security;

drop policy if exists "npf_public_read" on public.npf_workspace;
create policy "npf_public_read" on public.npf_workspace for select to anon using (id = 1);

drop policy if exists "npf_public_insert" on public.npf_workspace;
create policy "npf_public_insert" on public.npf_workspace for insert to anon with check (id = 1);

drop policy if exists "npf_public_update" on public.npf_workspace;
create policy "npf_public_update" on public.npf_workspace for update to anon using (id = 1) with check (id = 1);

insert into public.npf_workspace (id) values (1) on conflict (id) do nothing;

-- Estas políticas permiten usar el HTML sin iniciar sesión.
-- Cuando agreguemos usuarios y contraseñas, deberán reemplazarse por políticas privadas.
